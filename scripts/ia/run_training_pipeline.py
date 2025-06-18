from pathlib import Path
import argparse
import sys

sys.path.append(str(Path(__file__).resolve().parent))
from fetch_firestore_data import fetch_records
from train_model import train_model
from prepare_dataset import prepare_dataset
from evaluate_model import evaluate_model

def run_pipeline(category: str, service_account: Path, workdir: Path) -> None:
    workdir.mkdir(parents=True, exist_ok=True)
    json_path = workdir / "records.json"
    csv_path = workdir / "dataset.csv"
    model_path = workdir / "model.pkl"

    records = fetch_records(category, service_account)
    with open(json_path, "w", encoding="utf-8") as f:
        import json
        json.dump(records, f, ensure_ascii=False, indent=2)

    prepare_dataset(json_path, csv_path)
    train_model(csv_path, model_path)
    evaluate_model(csv_path, model_path)


def main() -> None:
    parser = argparse.ArgumentParser(description="Run full training pipeline")
    parser.add_argument("category", help="Category under logs_ia")
    parser.add_argument("--service-account", required=True, dest="service_account",
                        help="Path to Firebase serviceAccountKey.json")
    parser.add_argument("--workdir", default="training", help="Working directory for outputs")
    args = parser.parse_args()

    run_pipeline(args.category, Path(args.service_account), Path(args.workdir))


if __name__ == "__main__":
    main()
