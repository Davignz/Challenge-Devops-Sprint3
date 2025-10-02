#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../.env"

az group create -n "rg-devops-sprint3" -l "brazilsouth"

az acr create -g "rg-devops-sprint3" -n "acrdevopssprint3" --sku "Basic" --admin-enabled true
az acr show -n "acrdevopssprint3" --query loginServer -o tsv
