import argparse
import pickle
from pathlib import Path

import pandas as pd
from sklearn.metrics import precision_score, recall_score
from sklearn.model_selection import train_test_split


def evaluate_model(csv_path: Path, model_path: Path, label_column: str = "label") -> None:
    """Evaluate the model and print precision/recall."""
    df = pd.read_csv(csv_path)
    if label_column not in df.columns:
        raise ValueError(f"Dataset must contain '{label_column}' column")
    X = df.drop(columns=[label_column])
    y = df[label_column]

    with open(model_path, "rb") as f:
        model = pickle.load(f)

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    y_pred = model.predict(X_test)
    precision = precision_score(y_test, y_pred, average="weighted", zero_division=0)
    recall = recall_score(y_test, y_pred, average="weighted", zero_division=0)

    print(f"Precision: {precision:.4f}")
    print(f"Recall: {recall:.4f}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Evaluate a trained model")
    parser.add_argument("csv_path", help="Path to dataset CSV")
    parser.add_argument("model_path", help="Trained model file")
    parser.add_argument("--label", default="label", help="Name of the label column")
    args = parser.parse_args()

    evaluate_model(Path(args.csv_path), Path(args.model_path), args.label)


if __name__ == "__main__":
    main()
