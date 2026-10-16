# Question: Use Kustomize overlays for dev and production
#
# A shared base and starter overlays are available in ~/cka-kustomize-overlays.
# Keep the base unchanged and configure the overlays independently.
#
# Tasks:
# 1. Configure overlays/dev to deploy into kustomize-dev with a dev- name prefix,
#    1 replica, and image nginx:1.27.4.
# 2. Configure overlays/prod to deploy into kustomize-prod with a prod- name prefix,
#    4 replicas, and image nginx:1.27.5.
# 3. Preview each overlay using kubectl kustomize.
# 4. Apply both overlays and verify that namespace, replica count, and image differ
#    as requested while both environments retain the base Service and receive
#    their corresponding name prefixes.
