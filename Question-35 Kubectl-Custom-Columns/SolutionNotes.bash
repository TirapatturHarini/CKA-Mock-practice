NS=jsonpath-lab

# Inline custom-columns expressions use JSONPath paths after each header name.
kubectl get pods -n "$NS" -o 'custom-columns=NAME:.metadata.name,APP:.metadata.labels.app,PHASE:.status.phase,NODE:.spec.nodeName,CONTAINERS:.spec.containers[*].name,IMAGES:.spec.containers[*].image'

# --no-headers suppresses the headings; --sort-by accepts a JSONPath field path.
kubectl get pods -n "$NS" --sort-by=.metadata.name --no-headers \
  -o 'custom-columns=NAME:.metadata.name,APP:.metadata.labels.app,PHASE:.status.phase'

# A reusable custom-columns definition file.
cat <<'EOF' > ~/pod-columns.txt
NAME:.metadata.name
NODE:.spec.nodeName
APP:.metadata.labels.app
READY:.status.containerStatuses[*].ready
EOF
kubectl get pods -n "$NS" --sort-by=.spec.nodeName \
  -o "custom-columns-file=$HOME/pod-columns.txt"

# Deployment fields, including the image nested under the first container.
kubectl get deployments -n "$NS" \
  -o 'custom-columns=NAME:.metadata.name,DESIRED:.spec.replicas,READY:.status.readyReplicas,IMAGE:.spec.template.spec.containers[*].image'

# Cluster-wide listing: namespace and name are both useful columns.
kubectl get pods -A --sort-by=.metadata.namespace \
  -o 'custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name'
