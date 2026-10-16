#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
bash "${REPO_ROOT}/scripts/prepare-kustomize-lab.sh" patches
kubectl create namespace kustomize-patch --dry-run=client -o yaml | kubectl apply -f -
echo "Kustomize patch lab ready at ~/cka-kustomize-patches"
