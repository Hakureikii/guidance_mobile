from sklearn.compose import ColumnTransformer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.preprocessing import OneHotEncoder
import pandas as pd
import os

# Create a class for the model and evaluate method which returns the result, findings, and percentages of each categories

script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(script_dir, "datasets_v2.2.xlsx")

TEXT_COLUMN = "referral_details"
HISTORY_COLUMN = "session_history"   # text: the counselor's remark from the MOST RECENT session only
CATEGORY_COLUMNS = ["previous_session_problem", "living_arrangement", "family_status"]

# How loudly each extra input speaks compared to the referral text (weight 1.0).
# Tuned on the 6,400-row set: dropdowns 0.2, remark 0.2. Much higher values drown out the text.
CATEGORY_WEIGHT = 0.2
HISTORY_WEIGHT = 0.2

# Words that say how OFTEN something happens, not what KIND of problem it is. The label model
# ignores them ("Always crying" is read as "crying"); the intensity model still sees them,
# because words like "constantly" help show how serious a case is.
FREQUENCY_WORDS = ["always", "often", "usually", "constantly", "frequently", "keeps"]

# Dropdown value / placeholder text for students with no earlier session.
NO_PREVIOUS = "No previous session"
NO_HISTORY = "No previous sessions on record."

# Common spellings that should map to the exact values the model was trained on.
# Keys are lowercase. Anything not matched here (or exactly, ignoring case) triggers a warning.
ALIASES = {
    "living_arrangement": {
        "living with relative/s": "Living with relatives",
        "living with relative": "Living with relatives",
        "with relatives": "Living with relatives",
        "relatives": "Living with relatives",
        "relative/s": "Living with relatives",
        "living with parent": "Living with parents",
        "with parents": "Living with parents",
        "parents": "Living with parents",
    },
    "family_status": {
        "single-parent": "Single parent",
        "single": "Single parent",
        "living together": "Living together (unmarried)",
        "live-in": "Living together (unmarried)",
        "cohabiting": "Living together (unmarried)",
    },
}


class Analysis:
    def __init__(self):
        # keep_default_na=False stops pandas from turning text like "None" into blanks
        self.dataset = pd.read_excel(file_path, keep_default_na=False)
        self.labels = self.dataset["label"]
        self.level = self.dataset["intensity"]

        # The exact values the model has seen for each dropdown column (lowercase -> exact)
        self._options = {
            col: {str(v).strip().lower(): v for v in self.dataset[col].unique()}
            for col in CATEGORY_COLUMNS
        }

        # Two preprocessors turn the 5 inputs into numbers. They are identical except that the
        # label one ignores FREQUENCY_WORDS in the referral text.
        self.label_preprocessor = self._make_preprocessor(stop_words=FREQUENCY_WORDS)
        self.intensity_preprocessor = self._make_preprocessor(stop_words=None)

        # Two separate models, so predicting one never disturbs the other
        self.label_model = MultinomialNB().fit(
            self.label_preprocessor.fit_transform(self.dataset), self.labels)
        self.intensity_model = MultinomialNB().fit(
            self.intensity_preprocessor.fit_transform(self.dataset), self.level)

    @staticmethod
    def _make_preprocessor(stop_words):
        return ColumnTransformer(
            [
                ("text", TfidfVectorizer(stop_words=stop_words), TEXT_COLUMN),
                ("history", TfidfVectorizer(), HISTORY_COLUMN),
                ("category", OneHotEncoder(handle_unknown="ignore"), CATEGORY_COLUMNS),
            ],
            transformer_weights={
                "text": 1.0,
                "history": HISTORY_WEIGHT,
                "category": CATEGORY_WEIGHT,
            },
        )

    def _canonical(self, column, value, default):
        """Match a dropdown value to the exact text the model was trained on.

        Empty values use `default`. Case and extra spaces are ignored, a few common
        spellings are mapped, and anything else prints a warning (the model would
        otherwise ignore that input without any error).
        """
        if value is None or not str(value).strip():
            return default

        key = str(value).strip().lower()
        options = self._options[column]
        if key in options:
            return options[key]
        if key in ALIASES.get(column, {}):
            return ALIASES[column][key]
        if column == "previous_session_problem":
            guess = f"{key.split()[0]} problem"          # "family" -> "Family Problem"
            if guess in options:
                return options[guess]

        print(f"WARNING: unrecognised {column} value {value!r}; this input will be ignored. "
              f"Expected one of: {sorted(options.values())}")
        return value

    def _to_row(self, student_input):
        """Turn the student_input dict into one clean row (a DataFrame) for the models."""
        text = student_input.get("referral_details")
        if not text or not str(text).strip():
            raise ValueError("referral_details is required")

        # session_history is ONE remark: the counselor's note from the most recent session.
        # If a list of remarks is sent, only the last (most recent) one is used.
        history = student_input.get("session_history")
        if isinstance(history, dict):
            raise ValueError("session_history is now text (the most recent guidance remark), not a dict of counts")
        if isinstance(history, (list, tuple)):
            history = history[-1] if history else ""
        history = (history or "").strip() or NO_HISTORY

        row = {
            TEXT_COLUMN: text,
            HISTORY_COLUMN: history,
            "previous_session_problem": self._canonical(
                "previous_session_problem", student_input.get("previous_session_problem"), NO_PREVIOUS),
            "living_arrangement": self._canonical(
                "living_arrangement", student_input.get("living_arrangement"), "Unknown"),
            "family_status": self._canonical(
                "family_status", student_input.get("family_status"), "Unknown"),
        }
        return pd.DataFrame([row])

    def evaluate(self, student_input):
        test = self.label_preprocessor.transform(self._to_row(student_input))
        prediction = str(self.label_model.predict(test)[0])

        # Built fresh on every call so results never pile up between requests
        probabilities = [
            {"label": f"{label}", "probability": f"{prob:.2%}"}
            for label, prob in zip(self.label_model.classes_, self.label_model.predict_proba(test)[0])
        ]

        print(f"Prediction: {prediction} | Probabilities: {probabilities}")
        return {'prediction': prediction, 'probabilities': probabilities}

    def intensity(self, student_input):
        test = self.intensity_preprocessor.transform(self._to_row(student_input))
        result = str(self.intensity_model.predict(test)[0])
        print(f"Intensity: {result}")
        return result