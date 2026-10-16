# Question: Route across namespaces using ReferenceGrant
#
# Gateway API CRDs and a placeholder GatewayClass are installed. Namespace apps has
# a store-svc Service; namespace edge is where the Gateway and HTTPRoute belong.
#
# Tasks:
# 1. Create Gateway edge-gateway in edge with HTTP listener edge-http on port 80.
# 2. Create HTTPRoute store-route in edge attached to edge-gateway. Route hostname
#    store.example.test and PathPrefix / to Service store-svc port 80 in namespace apps.
# 3. Create a ReferenceGrant in apps that permits HTTPRoute resources from namespace
#    edge to reference Service resources in apps.
# 4. Inspect the cross-namespace backendRef and grant. Explain why the route is not
#    permitted without ReferenceGrant.
#
# The placeholder controller means only API validation/resource inspection is tested.
