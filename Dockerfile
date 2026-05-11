ARG BASE_IMAGE=nvcr.io/nvidia/l4t-pytorch:r36.2.0-pth2.1-py3
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1
ENV APP_HOME=/workspace/payload

WORKDIR ${APP_HOME}

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev \
    build-essential \
    git \
    wget \
    curl \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install -r requirements.txt

COPY trt_builder.py .
COPY models ./models

RUN mkdir -p /workspace/payload/engines /workspace/payload/data

CMD ["/bin/bash"]