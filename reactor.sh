#!/bin/bash

# Update and install necessary packages
apt-get update
apt-get install -y build-essential cmake git libgl1-mesa-glx wget

# Navigate to the custom_nodes directory
COMFYUI_DIR="/workspace/ComfyUI"
CUSTOM_NODES_DIR="$COMFYUI_DIR/custom_nodes"
cd "$CUSTOM_NODES_DIR"

# Clone the ReActor node repository if it does not exist
REACTOR_NODE_DIR="$CUSTOM_NODES_DIR/comfyui-reactor-node"
if [ ! -d "$REACTOR_NODE_DIR" ]; then
    git clone https://github.com/Gourieff/comfyui-reactor-node.git
fi

# Navigate to the ReActor node directory
cd "$REACTOR_NODE_DIR"

# Run install.py
python install.py

# Create necessary directories for models
mkdir -p "$COMFYUI_DIR/models/ultralytics/bbox"
mkdir -p "$COMFYUI_DIR/models/sams"

# Download Ultralytics model
wget -O "$COMFYUI_DIR/models/ultralytics/bbox/face_yolov8m.pt" https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/detection/bbox/face_yolov8m.pt

# Download Sams models
wget -O "$COMFYUI_DIR/models/sams/sam_vit_l_0b3195.pth" https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/sams/sam_vit_l_0b3195.pth
wget -O "$COMFYUI_DIR/models/sams/sam_vit_b_01ec64.pth" https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/sams/sam_vit_b_01ec64.pth

# Navigate back to the ComfyUI directory
cd "$COMFYUI_DIR"

# Print completion message
echo "All nodes and models have been installed successfully."