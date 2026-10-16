# Question: Build and apply a Kustomize base
#
# Deployment and Service manifests are prepared in ~/cka-kustomize-base. Complete
# the Kustomize configuration so the application can be built and managed as a unit.
#
# Tasks:
# 1. Update kustomization.yaml to include deployment.yaml and service.yaml.
# 2. Add the namespace kustomize-base and a common label team=platform.
# 3. Preview the final YAML with kubectl kustomize.
# 4. Apply it with kubectl apply -k and verify the Deployment and Service.
#
# Do not apply the individual YAML files directly.
