#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-kustomize-lab.sh" base
kubectl create namespace kustomize-base --dry-run=client -o yaml | kubectl apply -f -
echo "Kustomize base lab ready at ~/cka-kustomize-base"
