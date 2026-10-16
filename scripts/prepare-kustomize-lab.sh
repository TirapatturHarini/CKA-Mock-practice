#!/bin/bash
set -euo pipefail

LAB="${1:-}"
if [[ -z "$LAB" ]]; then
  echo "Usage: $0 base|overlays|patches|generators" >&2
  exit 1
fi

ROOT="${HOME}/cka-kustomize-${LAB}"
mkdir -p "$ROOT"

case "$LAB" in
  base)
    cat <<'EOF' > "$ROOT/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: nginx
          image: nginx:1.27.5
          ports:
            - containerPort: 80
EOF
    cat <<'EOF' > "$ROOT/service.yaml"
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  selector:
    app: web
  ports:
    - name: http
      port: 80
      targetPort: 80
EOF
    cat <<'EOF' > "$ROOT/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources: []
EOF
    ;;
  overlays)
    mkdir -p "$ROOT/base" "$ROOT/overlays/dev" "$ROOT/overlays/prod"
    cat <<'EOF' > "$ROOT/base/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: nginx
          image: nginx:1.27.5
          ports:
            - containerPort: 80
EOF
    cat <<'EOF' > "$ROOT/base/service.yaml"
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  selector:
    app: web
  ports:
    - name: http
      port: 80
      targetPort: 80
EOF
    cat <<'EOF' > "$ROOT/base/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml
  - service.yaml
EOF
    for env in dev prod; do
      cat <<'EOF' > "$ROOT/overlays/$env/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../../base
EOF
    done
    ;;
  patches)
    mkdir -p "$ROOT/patches"
    cat <<'EOF' > "$ROOT/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payments
spec:
  replicas: 1
  selector:
    matchLabels:
      app: payments
  template:
    metadata:
      labels:
        app: payments
    spec:
      containers:
        - name: api
          image: nginx:1.27.5
          ports:
            - containerPort: 80
EOF
    cat <<'EOF' > "$ROOT/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml
patches: []
EOF
    cat <<'EOF' > "$ROOT/patches/payments.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payments
spec:
  replicas: 4
  template:
    spec:
      containers:
        - name: api
          image: nginx:1.27.4
          env:
            - name: LOG_LEVEL
              value: info
EOF
    ;;
  generators)
    cat <<'EOF' > "$ROOT/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: catalog
spec:
  replicas: 1
  selector:
    matchLabels:
      app: catalog
  template:
    metadata:
      labels:
        app: catalog
    spec:
      containers:
        - name: catalog
          image: nginx:1.27.5
          envFrom:
            - configMapRef:
                name: catalog-settings
            - secretRef:
                name: catalog-credentials
EOF
    cat <<'EOF' > "$ROOT/kustomization.yaml"
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml
configMapGenerator: []
secretGenerator: []
EOF
    ;;
  *)
    echo "Unknown lab '$LAB'. Use base|overlays|patches|generators." >&2
    exit 1
    ;;
esac

echo "Prepared Kustomize $LAB lab at $ROOT"
