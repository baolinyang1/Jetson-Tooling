# Jetson-Tooling
# Edge AI MLOps Pipeline & TensorRT Containerization

## Goal

This project builds a Jetson-ready Docker deployment environment for YOLOv8 object detection and TensorRT engine compilation.

## Files

- `Dockerfile` — Jetson L4T-based container image.
- `deploy.sh` — builds and runs the container on Jetson.
- `trt_builder.py` — converts YOLOv8 ONNX models into FP16 TensorRT engines.
- `models/` — place ONNX models here.
- `engines/` — TensorRT engines are saved here.

## Jetson Deployment

On the Jetson:

```bash
chmod +x deploy.sh
./deploy.sh
