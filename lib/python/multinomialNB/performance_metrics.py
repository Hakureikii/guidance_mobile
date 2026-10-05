from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.model_selection import train_test_split
from sklearn.metrics import (
    accuracy_score,
    precision_score,
    recall_score,
    f1_score,
    confusion_matrix,
    classification_report
)

import pandas as pd
import os


# Locate dataset
script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(script_dir, "dataset_v1.3.xlsx")

# Load dataset
dataset = pd.read_excel(file_path)

texts = dataset["text"]
labels = dataset["label"]


# Split dataset into training and testing
X_train, X_test, y_train, y_test = train_test_split(
    texts,
    labels,
    test_size=0.20,
    random_state=42,
    stratify=labels
)


# Create TF-IDF
vectorizer = TfidfVectorizer()

X_train = vectorizer.fit_transform(X_train)
X_test = vectorizer.transform(X_test)


# Create and train model
model = MultinomialNB()
model.fit(X_train, y_train)


# Make predictions using TEST data
y_pred = model.predict(X_test)


# Performance metrics
accuracy = accuracy_score(y_test, y_pred)

precision = precision_score(
    y_test,
    y_pred,
    average="weighted"
)

recall = recall_score(
    y_test,
    y_pred,
    average="weighted"
)

f1 = f1_score(
    y_test,
    y_pred,
    average="weighted"
)


# Display results
print("===== MODEL PERFORMANCE =====")

print(f"Accuracy:  {accuracy:.2%}")
print(f"Precision: {precision:.2%}")
print(f"Recall:    {recall:.2%}")
print(f"F1 Score:  {f1:.2%}")


# Classification report
print("\n===== CLASSIFICATION REPORT =====")
print(classification_report(y_test, y_pred))


# Confusion matrix
# print("===== CONFUSION MATRIX =====")
# print(confusion_matrix(y_test, y_pred))

cm = confusion_matrix(y_test, y_pred)

cm_df = pd.DataFrame(
    cm,
    index=["Academic Problem", "Family Problem",
           "Personal Problem", "Social Problem"],
    columns=["Academic Problem", "Family Problem",
             "Personal Problem", "Social Problem"]
)

print("===== CONFUSION MATRIX =====")
print(cm_df)