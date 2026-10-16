#!/bin/bash
set -euo pipefail

LAB="${1:-}"
if [[ -z "$LAB" ]]; then
  echo "Usage: $0 basic|matches|filters|cross-namespace|attachment|tls" >&2
  exit 1
fi

CRD_VERSION="v1.5.0"
kubectl apply -f "https://github.com/kubernetes-sigs/gateway-api/releases/download/${CRD_VERSION}/standard-install.yaml" >/dev/null
kubectl apply -f - <<'EOF'
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: cka-gateway-class
spec:
  controllerName: cka.example.invalid/gateway-controller
EOF

case "$LAB" in
  basic)
    NS="gw-basic"
    kubectl create namespace "$NS" --dry-run=client -o yaml | kubectl apply -f -
    kubectl -n "$NS" create deployment web --image=nginx:1.27.5 --replicas=2 --dry-run=client -o yaml | kubectl apply -f -
    kubectl -n "$NS" expose deployment web --name=web-svc --port=80 --target-port=80 --dry-run=client -o yaml | kubectl apply -f -
    ;;
  matches)
    NS="gw-matches"
    kubectl create namespace "$NS" --dry-run=client -o yaml | kubectl apply -f -
    for app in web api; do
      kubectl -n "$NS" create deployment "$app" --image=nginx:1.27.5 --replicas=1 --dry-run=client -o yaml | kubectl apply -f -
      kubectl -n "$NS" expose deployment "$app" --name="${app}-svc" --port=80 --target-port=80 --dry-run=client -o yaml | kubectl apply -f -
    done
    ;;
  filters)
    NS="gw-filters"
    kubectl create namespace "$NS" --dry-run=client -o yaml | kubectl apply -f -
    for app in blue green; do
      kubectl -n "$NS" create deployment "$app" --image=nginx:1.27.5 --replicas=1 --dry-run=client -o yaml | kubectl apply -f -
      kubectl -n "$NS" expose deployment "$app" --name="${app}-svc" --port=80 --target-port=80 --dry-run=client -o yaml | kubectl apply -f -
    done
    ;;
  cross-namespace)
    kubectl create namespace edge --dry-run=client -o yaml | kubectl apply -f -
    kubectl create namespace apps --dry-run=client -o yaml | kubectl apply -f -
    kubectl -n apps create deployment store --image=nginx:1.27.5 --replicas=1 --dry-run=client -o yaml | kubectl apply -f -
    kubectl -n apps expose deployment store --name=store-svc --port=80 --target-port=80 --dry-run=client -o yaml | kubectl apply -f -
    ;;
  attachment)
    kubectl create namespace infra --dry-run=client -o yaml | kubectl apply -f -
    kubectl create namespace tenant-blue --dry-run=client -o yaml | kubectl apply -f -
    kubectl create namespace tenant-red --dry-run=client -o yaml | kubectl apply -f -
    kubectl label namespace tenant-blue gateway-access=enabled --overwrite
    kubectl -n tenant-blue create deployment team-web --image=nginx:1.27.5 --replicas=1 --dry-run=client -o yaml | kubectl apply -f -
    kubectl -n tenant-blue expose deployment team-web --name=team-web-svc --port=80 --target-port=80 --dry-run=client -o yaml | kubectl apply -f -
    ;;
  tls)
    NS="gw-tls"
    kubectl create namespace "$NS" --dry-run=client -o yaml | kubectl apply -f -
    kubectl -n "$NS" create deployment secure-web --image=nginx:1.27.5 --replicas=1 --dry-run=client -o yaml | kubectl apply -f -
    kubectl -n "$NS" expose deployment secure-web --name=secure-web-svc --port=80 --target-port=80 --dry-run=client -o yaml | kubectl apply -f -
    TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$TMP_DIR"' EXIT
    openssl req -x509 -nodes -days 30 -newkey rsa:2048 \
      -keyout "$TMP_DIR/tls.key" -out "$TMP_DIR/tls.crt" \
      -subj "/CN=secure.example.test" >/dev/null 2>&1
    kubectl -n "$NS" create secret tls secure-web-tls \
      --cert="$TMP_DIR/tls.crt" --key="$TMP_DIR/tls.key" \
      --dry-run=client -o yaml | kubectl apply -f -
    ;;
  *)
    echo "Unknown lab '$LAB'. Use basic|matches|filters|cross-namespace|attachment|tls." >&2
    exit 1
    ;;
esac

echo "Prepared Gateway API $LAB lab. GatewayClass cka-gateway-class uses a placeholder controller."
echo "This lab validates Gateway/HTTPRoute configuration only; no data plane is installed."
