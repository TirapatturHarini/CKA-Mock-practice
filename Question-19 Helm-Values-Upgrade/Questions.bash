# Question: Configure a Helm release with a values file
#
# Release web is installed in namespace helm-values using the local chart at
# ~/cka-helm-chart. Update the release through a Helm values file.
#
# Tasks:
# 1. Inspect the chart metadata and default values.
# 2. Create ~/web-values.yaml to configure 3 replicas, image nginx:1.27.4,
#    and a ClusterIP Service on port 8080.
# 3. Upgrade release web using that values file.
# 4. Verify the effective Helm values and the Deployment/Service configuration.
#
# Do not edit the chart templates or manually patch Kubernetes resources.
