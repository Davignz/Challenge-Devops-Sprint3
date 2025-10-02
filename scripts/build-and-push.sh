#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../.env"

LOGIN_SERVER=$(az acr show -n "$ACR_NAME" --query loginServer -o tsv)

# Faça o build da imagem (ajuste o Dockerfile/projeto antes)
docker build -t "$IMAGE_NAME:$IMAGE_TAG" -f "$(dirname "$0")/../Dockerfile" "$(dirname "$0")/.."
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG"

# Login no ACR e push
az acr login -n "$ACR_NAME"
docker push "$LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG"
