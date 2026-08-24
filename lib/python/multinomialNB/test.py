from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
import pandas as pd
import os

# Create a class for the model and evaluate method which returns the result, findings, and percentages of each categories

script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(script_dir, "dataset_v1.6.xlsx")

class Analysis:
    def __init__(self):
        self.dataset = pd.read_excel(file_path)
        self.texts = self.dataset["text"]
        self.labels = self.dataset["label"]
        self.level = self.dataset["intensity"]

        self.probabilities = []

        self.vectorizer = TfidfVectorizer()
        
        self.model = MultinomialNB()
        
        self.X = self.vectorizer.fit_transform(self.texts)
        self.model.fit(self.X, self.labels)

    def evaluate(self, sample):
        test = self.vectorizer.transform([sample])
        prediction = str(self.model.predict(test)[0])

        probabilities = self.model.predict_proba(test)[0]
        for label, prob in zip(self.model.classes_, probabilities):
            self.probabilities.append(
                {
                    "label": f"{label}",
                    "probability": f"{prob:.2%}"
                }
            )
            
        return {'prediction': prediction, 'probabilities': self.probabilities}
    
    def intensity(self, sample):
        self.model.fit(self.X, self.level)
        test = self.vectorizer.transform([sample])
        intensity = str(self.model.predict(test)[0])
        
        return intensity