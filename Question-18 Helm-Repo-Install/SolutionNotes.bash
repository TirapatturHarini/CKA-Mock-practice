# Add/update the official repository and search without installing its chart.
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm search repo ingress-nginx --versions

# Install the provided local chart with a release name and an override.
helm install web ~/cka-helm-chart \
  --namespace helm-install \
  --set replicaCount=2

# Verify release metadata and rendered Kubernetes resources.
helm list --namespace helm-install
helm status web --namespace helm-install
kubectl get deployment,service --namespace helm-install
