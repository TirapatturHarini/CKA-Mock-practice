# Question: Helm repository discovery and chart installation
#
# The cluster is ready for a new web release. Helm is installed, and a small local
# chart is available at ~/cka-helm-chart so the workload install does not depend on
# an external chart or container registry being reachable during setup.
#
# Tasks:
# 1. Add the official ingress-nginx Helm repository with the name ingress-nginx:
#    https://kubernetes.github.io/ingress-nginx
# 2. Update the repository index and search for ingress-nginx charts, including
#    available versions. Do not install the ingress controller.
# 3. Install the local chart as release web in namespace helm-install with 2 replicas.
# 4. Verify the Helm release and the Deployment/Service in the namespace.
#
# Hint: use helm repo, helm search, helm install, helm list, and kubectl get.
