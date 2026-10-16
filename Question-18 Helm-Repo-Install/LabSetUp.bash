#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-helm-chart.sh"
kubectl create namespace helm-install --dry-run=client -o yaml | kubectl apply -f -
if helm status web --namespace helm-install >/dev/null 2>&1; then
	helm uninstall web --namespace helm-install
fi

echo "Helm install lab is ready. No Helm release has been installed yet."
echo "Namespace: helm-install; local chart: ${HOME}/cka-helm-chart"
