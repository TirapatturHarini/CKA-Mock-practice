# Question: Manage a Helm release lifecycle
#
# Release web is installed in namespace helm-lifecycle using the local chart at
# ~/cka-helm-chart.
#
# Tasks:
# 1. List Helm releases and inspect the status and history of web.
# 2. Upgrade web to 2 replicas and verify the resulting Deployment.
# 3. Uninstall the Helm release.
# 4. Verify the release is no longer listed and its Deployment and Service are gone.
#
# Do not delete the namespace.
