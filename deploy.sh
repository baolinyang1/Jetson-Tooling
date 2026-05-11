#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-edge-ai-payload}"
IMAGE_TAG="${IMAGE_TAG:-jetson}"
CONTAINER_NAME="${CONTAINER_NAME:-edge-ai-payload}"
BASE_IMAGE="${BASE_IMAGE:-nvcr.io/nvidia/l4t-pytorch:r36.2.0-pth2.1-py3}"

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODELS_DIR="${PROJECT_DIR}/models"
ENGINES_DIR="${PROJECT_DIR}/engines"
DATA_DIR="${PROJECT_DIR}/data"

mkdir -p "$MODELS_DIR" "$ENGINES_DIR" "$DATA_DIR"

echo "Building Docker image..."
docker buildx build \
  --platform linux/arm64 \
  --build-arg BASE_IMAGE="$BASE_IMAGE" \
  -t "${IMAGE_NAME}:${IMAGE_TAG}" \
  --load \
  "$PROJECT_DIR"

echo "Starting container..."
docker run -it --rm \
  --runtime nvidia \
  --network host \
  --name "$CONTAINER_NAME" \
  -v "${MODELS_DIR}:/workspace/payload/models" \
  -v "${ENGINES_DIR}:/workspace/payload/engines" \
  -v "${DATA_DIR}:/workspace/payload/data" \
  "${IMAGE_NAME}:${IMAGE_TAG}"