# Edge AI Payload: Jetson Docker + TensorRT Builder

This project packages a YOLOv8 object detection payload for NVIDIA Jetson devices using L4T Docker containers and TensorRT FP16 engine compilation.

## Files

- `Dockerfile`: Jetson/L4T-compatible runtime image.
- `deploy.sh`: Builds and runs the container on Jetson.
- `trt_builder.py`: Converts YOLOv8 ONNX models to TensorRT `.engine`.
- `models/`: Place `.onnx` models here.
- `engines/`: TensorRT engines are saved here.

## Jetson Usage

```bash
chmod +x deploy.sh
./deploy.sh

#Then inside the container, run 
python3 trt_builder.py --model models/yolov8n.onnx 

