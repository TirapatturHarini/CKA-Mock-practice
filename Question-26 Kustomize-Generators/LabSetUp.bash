#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-kustomize-lab.sh" generators
kubectl create namespace kustomize-generated --dry-run=client -o yaml | kubectl apply -f -
echo "Kustomize generator lab ready at ~/cka-kustomize-generators"
