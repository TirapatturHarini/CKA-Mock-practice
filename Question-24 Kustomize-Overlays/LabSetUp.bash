#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-kustomize-lab.sh" overlays
for ns in kustomize-dev kustomize-prod; do
  kubectl create namespace "$ns" --dry-run=client -o yaml | kubectl apply -f -
done
echo "Kustomize overlay lab ready at ~/cka-kustomize-overlays"
