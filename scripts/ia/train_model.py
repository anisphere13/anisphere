import argparse
import pickle
from pathlib import Path

import pandas as pd
from sklearn.ensemble import RandomForestClassifier


def train_model(csv_path: Path, model_path: Path, label_column: str = "label") -> None:
    """Train a simple model and save it."""
    df = pd.read_csv(csv_path)
    if label_column not in df.columns:
        raise ValueError(f"Dataset must contain '{label_column}' column")
    X = df.drop(columns=[label_column])
    y = df[label_column]

    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X, y)

    with open(model_path, "wb") as f:
        pickle.dump(model, f)
    print(f"Model saved to {model_path}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Train a model from a CSV dataset")
    parser.add_argument("csv_path", help="Path to dataset CSV")
    parser.add_argument("--output", default="model.pkl", help="Output model file")
    parser.add_argument("--label", default="label", help="Name of the label column")
    args = parser.parse_args()

    train_model(Path(args.csv_path), Path(args.output), args.label)


if __name__ == "__main__":
    main()
