import argparse
import json
from pathlib import Path

import pandas as pd


def prepare_dataset(json_path: Path, output_csv: Path) -> None:
    """Load records from JSON and export a cleaned CSV."""
    with open(json_path, "r", encoding="utf-8") as f:
        records = json.load(f)

    df = pd.DataFrame(records)
    # Drop empty columns and sort by timestamp if present
    df = df.dropna(axis=1, how="all")
    if "timestamp" in df.columns:
        df["timestamp"] = pd.to_datetime(df["timestamp"], errors="coerce")
        df = df.sort_values("timestamp")
    df.to_csv(output_csv, index=False)
    print(f"Dataset saved to {output_csv}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Prepare dataset from JSON record file")
    parser.add_argument("json_path", help="Path to records JSON file")
    parser.add_argument("--output", default="dataset.csv", help="Output CSV path")
    args = parser.parse_args()

    prepare_dataset(Path(args.json_path), Path(args.output))


if __name__ == "__main__":
    main()
