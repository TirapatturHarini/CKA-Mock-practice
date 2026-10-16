# Question: Control HTTPRoute attachment with allowedRoutes
#
# Gateway API CRDs and placeholder GatewayClass cka-gateway-class are installed.
# Namespace tenant-blue has label gateway-access=enabled; tenant-red does not.
# Deployment team-web and Service team-web-svc are in tenant-blue.
#
# Tasks:
# 1. Create Gateway shared-gateway in namespace infra with HTTP listener shared-http
#    on port 80 and hostname team.example.test.
# 2. Configure listener allowedRoutes to allow HTTPRoute resources only from
#    namespaces matching gateway-access=enabled.
# 3. Create HTTPRoute team-route in tenant-blue. Reference the Gateway in namespace
#    infra and listener shared-http; route PathPrefix / to team-web-svc port 80.
# 4. Inspect namespace labels and resource specs; explain why an otherwise identical
#    HTTPRoute in tenant-red would not attach to the listener.
#
# The placeholder GatewayClass has no controller, so validate attachment policy in
# the resource specs rather than expecting Accepted=True or working HTTP traffic.
