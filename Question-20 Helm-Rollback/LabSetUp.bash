#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-helm-chart.sh"
if helm status web --namespace helm-rollback >/dev/null 2>&1; then
  helm uninstall web --namespace helm-rollback
fi
helm upgrade --install web "${HOME}/cka-helm-chart" \
  --namespace helm-rollback --create-namespace --set replicaCount=1
helm upgrade web "${HOME}/cka-helm-chart" \
  --namespace helm-rollback --set replicaCount=4

echo "Helm rollback lab is ready. Release web has two revisions."
helm history web --namespace helm-rollback
