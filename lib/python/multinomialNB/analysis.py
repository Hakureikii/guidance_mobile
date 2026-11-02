from sklearn.compose import ColumnTransformer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.preprocessing import OneHotEncoder
import pandas as pd
import os

# Create a class for the model and evaluate method which returns the result, findings, and percentages of each categories

script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(script_dir, "datasets_v2.xlsx")

TEXT_COLUMN = "referral_details"
CATEGORY_COLUMNS = ["previous_session_problem", "living_arrangement", "family_status"]
HISTORY_COLUMNS = [
    "session_history_family",
    "session_history_academic",
    "session_history_personal",
    "session_history_social",
]

# How loudly the 4 context inputs speak compared to the text.
# Tuned with TF-IDF: ~0.1 works best. Above ~0.4 the context drowns out the text.
CONTEXT_WEIGHT = 0.1


class Analysis:
    def __init__(self):
        self.dataset = pd.read_excel(file_path)
        self.labels = self.dataset["label"]
        self.level = self.dataset["intensity"]

        # One preprocessor turns all 5 inputs into a single row of numbers
        self.preprocessor = ColumnTransformer(
            [
                ("text", TfidfVectorizer(), TEXT_COLUMN),
                ("category", OneHotEncoder(handle_unknown="ignore"), CATEGORY_COLUMNS),
                ("history", "passthrough", HISTORY_COLUMNS),
            ],
            transformer_weights={
                "text": 1.0,
                "category": CONTEXT_WEIGHT,
                "history": CONTEXT_WEIGHT,
            },
        )
        self.X = self.preprocessor.fit_transform(self.dataset)

        # Two separate models, so predicting one never disturbs the other
        self.label_model = MultinomialNB().fit(self.X, self.labels)
        self.intensity_model = MultinomialNB().fit(self.X, self.level)

    def _to_features(self, student_input):
        """Turn the nested student_input dict into the numbers the models expect."""
        text = student_input.get("referral_details")
        if not text or not str(text).strip():
            raise ValueError("referral_details is required")

        history = student_input.get("session_history") or {}
        row = {
            TEXT_COLUMN: text,
            "previous_session_problem": student_input.get("previous_session_problem") or "None",
            "living_arrangement": student_input.get("living_arrangement") or "Unknown",
            "family_status": student_input.get("family_status") or "Unknown",
            "session_history_family": history.get("family", 0),
            "session_history_academic": history.get("academic", 0),
            "session_history_personal": history.get("personal", 0),
            "session_history_social": history.get("social", 0),
        }
        return self.preprocessor.transform(pd.DataFrame([row]))

    def evaluate(self, student_input):
        test = self._to_features(student_input)
        prediction = str(self.label_model.predict(test)[0])

        # Built fresh on every call so results never pile up between requests
        probabilities = [
            {"label": f"{label}", "probability": f"{prob:.2%}"}
            for label, prob in zip(self.label_model.classes_, self.label_model.predict_proba(test)[0])
        ]
        
        print(f"Prediction: {prediction}, Probabilities: {probabilities}")
      #   return {'prediction': prediction, 'probabilities': probabilities}

    def intensity(self, student_input):
        test = self._to_features(student_input)
        print(f"Intensity Prediction: {self.intensity_model.predict(test)[0]}")
      #   return str(self.intensity_model.predict(test)[0])
     
     
student_input: dict = {
    "referral_details": "Student has difficulty concentrating "
                        "and frequently argues with classmates.",

    "previous_session_problem": "Academic Problem",

    "session_history": {
        "family": 3,
        "academic": 1,
        "personal": 0,
        "social": 0
    },

    "living_arrangement": "Living with relatives",

    "family_status": "Separated"
}

test_eval = Analysis()
test_eval.evaluate(student_input)
test_eval.intensity(student_input)