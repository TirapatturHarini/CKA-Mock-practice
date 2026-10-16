#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-helm-chart.sh"
if helm status web --namespace helm-lifecycle >/dev/null 2>&1; then
  helm uninstall web --namespace helm-lifecycle
fi
helm upgrade --install web "${HOME}/cka-helm-chart" \
  --namespace helm-lifecycle --create-namespace --set replicaCount=1

echo "Helm release lifecycle lab is ready. Release web is installed."
