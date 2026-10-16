# Validate the chart and inspect its metadata.
helm lint ~/cka-helm-chart
helm show chart ~/cka-helm-chart

# Render manifests locally; helm template does not install resources.
helm template web ~/cka-helm-chart \
  --namespace helm-template \
  --set replicaCount=3 > ~/rendered-web.yaml

# Inspect rendered resources and confirm the cluster remains unchanged.
cat ~/rendered-web.yaml
helm list --namespace helm-template
kubectl get all --namespace helm-template
