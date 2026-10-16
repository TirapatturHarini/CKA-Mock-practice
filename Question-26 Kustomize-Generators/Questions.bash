# Question: Generate ConfigMaps and Secrets with Kustomize
#
# A catalog Deployment in ~/cka-kustomize-generators references ConfigMap
# catalog-settings and Secret catalog-credentials by their logical names.
#
# Tasks:
# 1. Configure namespace kustomize-generated and include deployment.yaml.
# 2. Generate ConfigMap catalog-settings with LOG_LEVEL=debug and FEATURE_SEARCH=true.
# 3. Generate Secret catalog-credentials with username=catalog and password=practice-only.
# 4. Preview/apply with kubectl apply -k and verify that Kustomize rewrites the
#    Deployment references to generated, hash-suffixed object names.
#
# These lab credentials are disposable examples, not real secrets.
