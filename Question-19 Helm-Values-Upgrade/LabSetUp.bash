#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-helm-chart.sh"
if helm status web --namespace helm-values >/dev/null 2>&1; then
  helm uninstall web --namespace helm-values
fi
helm upgrade --install web "${HOME}/cka-helm-chart" \
  --namespace helm-values --create-namespace --set replicaCount=1

echo "Helm values lab is ready. Release web is installed with the chart defaults."
