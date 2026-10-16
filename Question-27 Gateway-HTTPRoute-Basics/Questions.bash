# Question: Create a Gateway and attach an HTTPRoute
#
# Gateway API CRDs, a placeholder GatewayClass named cka-gateway-class, and a web
# Deployment/Service are prepared in namespace gw-basic.
#
# Tasks:
# 1. Create Gateway web-gateway using cka-gateway-class with an HTTP listener on
#    port 80 named web-http for hostname app.example.test.
# 2. Create HTTPRoute web-route for the same hostname and attach it to listener
#    web-http using parentRefs.sectionName.
# 3. Route PathPrefix / to Service web-svc port 80.
# 4. Inspect Gateway and HTTPRoute status/conditions and verify backend names/ports.
#
# This lab uses a placeholder controller: validate resource structure and status
# conditions; no data plane is installed, so HTTP traffic is not expected to work.
