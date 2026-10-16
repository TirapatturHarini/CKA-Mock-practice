#!/bin/bash
set -euo pipefail

NS="jsonpath-lab"
kubectl create namespace "$NS" --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-settings
  namespace: jsonpath-lab
  labels:
    app: frontend
    example.com/team: platform
data:
  LOG_LEVEL: info
  FEATURE_FLAG: enabled
---
apiVersion: v1
kind: Secret
metadata:
  name: app-credentials
  namespace: jsonpath-lab
  labels:
    app: frontend
type: Opaque
stringData:
  username: cka-user
  password: practice-only
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  namespace: jsonpath-lab
  labels:
    app: frontend
    tier: web
    release: stable
  annotations:
    example.com/owner: platform-team
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
        tier: web
        release: stable
      annotations:
        example.com/owner: platform-team
    spec:
      initContainers:
        - name: init-check
          image: busybox:1.36
          command: ["sh", "-c", "echo init complete"]
      containers:
        - name: nginx
          image: nginx:1.27.5
          ports:
            - name: http
              containerPort: 80
          env:
            - name: LOG_LEVEL
              valueFrom:
                configMapKeyRef:
                  name: app-settings
                  key: LOG_LEVEL
        - name: metrics
          image: busybox:1.36
          command: ["sh", "-c", "while true; do sleep 3600; done"]
          ports:
            - name: metrics
              containerPort: 9113
---
apiVersion: v1
kind: Service
metadata:
  name: frontend
  namespace: jsonpath-lab
  labels:
    app: frontend
spec:
  selector:
    app: frontend
  ports:
    - name: http
      port: 80
      targetPort: http
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
  namespace: jsonpath-lab
  labels:
    app: api
    tier: backend
    release: canary
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
        tier: backend
        release: canary
    spec:
      containers:
        - name: api
          image: nginx:1.27.5
          ports:
            - name: http
              containerPort: 80
EOF

echo "JSONPath fixtures applied in namespace ${NS}."
kubectl rollout status deployment/frontend -n "$NS" --timeout=120s
kubectl rollout status deployment/api -n "$NS" --timeout=120s
