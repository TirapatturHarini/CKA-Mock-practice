# Inspect the existing release and its history.
helm list --namespace helm-lifecycle
helm status web --namespace helm-lifecycle
helm history web --namespace helm-lifecycle

# Upgrade the release and verify the workload.
helm upgrade web ~/cka-helm-chart \
  --namespace helm-lifecycle \
  --set replicaCount=2
kubectl get deployment,service --namespace helm-lifecycle

# Uninstall the release and confirm its managed resources are removed.
helm uninstall web --namespace helm-lifecycle
helm list --namespace helm-lifecycle
kubectl get deployment,service --namespace helm-lifecycle
