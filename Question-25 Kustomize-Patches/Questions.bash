# Question: Patch Kubernetes resources with Kustomize
#
# A Deployment and a strategic-merge patch are prepared in ~/cka-kustomize-patches.
# The patch file is not yet included by kustomization.yaml.
#
# Tasks:
# 1. Configure Kustomize to apply patches/payments.yaml to the payments Deployment.
# 2. Preview and apply the result to namespace kustomize-patch.
# 3. Verify 4 replicas, image nginx:1.27.4, and LOG_LEVEL=info on container api.
# 4. Use kubectl kustomize/describe/get to validate the merged resource.
#
# Do not use kubectl patch or edit the source Deployment manifest.
