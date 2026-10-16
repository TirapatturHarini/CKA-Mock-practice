#!/bin/bash
set -euo pipefail

if ! command -v helm >/dev/null 2>&1; then
  echo "Helm is not installed or is not on PATH. Install/enable Helm before running this lab." >&2
  exit 1
fi

CHART_DIR="${HOME}/cka-helm-chart"
mkdir -p "${CHART_DIR}/templates"

cat <<'EOF' > "${CHART_DIR}/Chart.yaml"
apiVersion: v2
name: cka-web
version: 0.1.0
appVersion: "1.27.5"
type: application
description: A minimal local chart for CKA Helm practice
EOF

cat <<'EOF' > "${CHART_DIR}/values.yaml"
replicaCount: 1
image:
  repository: nginx
  tag: "1.27.5"
service:
  type: ClusterIP
  port: 80
EOF

cat <<'EOF' > "${CHART_DIR}/templates/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}
  labels:
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app.kubernetes.io/instance: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app.kubernetes.io/name: {{ .Chart.Name }}
        app.kubernetes.io/instance: {{ .Release.Name }}
    spec:
      containers:
        - name: web
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - name: http
              containerPort: 80
EOF

cat <<'EOF' > "${CHART_DIR}/templates/service.yaml"
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}
  labels:
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Release.Name }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - name: http
      port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
  selector:
    app.kubernetes.io/instance: {{ .Release.Name }}
EOF

echo "Prepared local practice chart at ${CHART_DIR}"
