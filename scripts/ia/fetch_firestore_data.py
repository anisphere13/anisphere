import argparse
import json
from pathlib import Path

import firebase_admin
from firebase_admin import credentials, firestore


def fetch_records(category: str, service_account: Path) -> list[dict]:
    """Retrieve documents from Firestore and return them as records."""
    if not firebase_admin._apps:
        cred = credentials.Certificate(str(service_account))
        firebase_admin.initialize_app(cred)
    db = firestore.client()
    docs = db.collection("logs_ia").document(category).collection("entries").stream()
    records = []
    for doc in docs:
        data = doc.to_dict() or {}
        data["id"] = doc.id
        records.append(data)
    return records


def main() -> None:
    parser = argparse.ArgumentParser(description="Export Firestore logs to JSON")
    parser.add_argument("category", help="Category under logs_ia")
    parser.add_argument("--service-account", required=True, dest="service_account",
                        help="Path to Firebase serviceAccountKey.json")
    parser.add_argument("--output", default="firestore_records.json",
                        help="Path to output JSON file")
    args = parser.parse_args()

    records = fetch_records(args.category, Path(args.service_account))
    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(records, f, ensure_ascii=False, indent=2)
    print(f"Exported {len(records)} records to {args.output}")


if __name__ == "__main__":
    main()
