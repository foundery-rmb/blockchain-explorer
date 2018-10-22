#!/bin/bash

# Run from root folder

# ============================================================
# Set version tag number
# ============================================================
TAG=$(git rev-parse --short HEAD)
NAME="fabric-blockchain-explorer"

# ============================================================
# Build image
# ============================================================
echo docker build --tag foundery.azurecr.io/foundery/${NAME}:${TAG} -f Dockerfile .
docker build --tag foundery.azurecr.io/foundery/${NAME}:${TAG} -f Dockerfile .

# ============================================================
# Add tags
# ============================================================
docker tag foundery.azurecr.io/foundery/${NAME}:${TAG} foundery.azurecr.io/foundery/${NAME}:latest
