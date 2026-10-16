# Inspect chart metadata and its defaults.
helm show chart ~/cka-helm-chart
helm show values ~/cka-helm-chart

# Write the requested overrides.
cat <<'EOF' > ~/web-values.yaml
replicaCount: 3
image:
  repository: nginx
  tag: "1.27.4"
service:
  type: ClusterIP
  port: 8080
EOF

# Upgrade the existing release and confirm the values/resources.
helm upgrade web ~/cka-helm-chart \
  --namespace helm-values \
  --values ~/web-values.yaml
helm get values web --namespace helm-values
helm get values web --namespace helm-values --all
kubectl get deployment,service web --namespace helm-values -o wide
