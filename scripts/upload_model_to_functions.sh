#!/bin/bash
# Upload a trained model package to the Firebase Functions directory.
# Usage: ./upload_model_to_functions.sh path/to/model_package.zip

set -euo pipefail

PACKAGE=${1:-build/model/model_package.zip}
TARGET_DIR="functions/model_packages"
mkdir -p "$TARGET_DIR"
cp "$PACKAGE" "$TARGET_DIR/" && echo "Model package copied to $TARGET_DIR"
