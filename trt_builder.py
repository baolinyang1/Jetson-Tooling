import argparse
from pathlib import Path
import shutil
from ultralytics import YOLO


def build_engine(
    model_path: str,
    imgsz: int,
    batch: int,
    half: bool,
    dynamic: bool,
    workspace: float | None,
    device: str | None,
    nms: bool,
):
    model_path = Path(model_path)

    if not model_path.exists():
        raise FileNotFoundError(f"Model file not found: {model_path}")

    model = YOLO(str(model_path))

    exported_path = model.export(
        format="engine",
        imgsz=imgsz,
        batch=batch,
        half=half,
        dynamic=dynamic,
        workspace=workspace,
        device=device,
        nms=nms,
    )

    exported_path = Path(exported_path)

    engines_dir = Path("engines")
    engines_dir.mkdir(exist_ok=True)

    target_path = engines_dir / exported_path.name

    shutil.move(str(exported_path), str(target_path))

    print(f"TensorRT engine exported to: {target_path}")


def main():
    parser = argparse.ArgumentParser(
        description="Export YOLO model to FP16 TensorRT engine using Ultralytics."
    )

    parser.add_argument("--model", required=True, help="Path to YOLO .pt or .onnx model")
    parser.add_argument("--imgsz", type=int, default=640)
    parser.add_argument("--batch", type=int, default=8)
    parser.add_argument("--workspace", type=float, default=None)
    parser.add_argument("--device", default=0)
    parser.add_argument("--no-half", action="store_true")
    parser.add_argument("--no-dynamic", action="store_true")
    parser.add_argument("--nms", action="store_true")

    args = parser.parse_args()

    build_engine(
        model_path=args.model,
        imgsz=args.imgsz,
        batch=args.batch,
        half=not args.no_half,
        dynamic=not args.no_dynamic,
        workspace=args.workspace,
        device=args.device,
        nms=args.nms,
    )


if __name__ == "__main__":
    main()