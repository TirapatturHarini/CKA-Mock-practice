#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-helm-chart.sh"
kubectl create namespace helm-template --dry-run=client -o yaml | kubectl apply -f -

echo "Helm template/lint lab is ready. The chart is not installed in the cluster."
