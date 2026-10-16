# Question: Use HTTPRoute filters and weighted backendRefs
#
# Gateway API CRDs, a placeholder GatewayClass, and blue-svc/green-svc backends are
# ready in namespace gw-filters. Create Gateway shop-gateway with HTTP listener
# shop-http, port 80, hostname shop.example.test.
#
# Tasks:
# 1. Create HTTPRoute shop-route attached to shop-http for shop.example.test.
# 2. For PathPrefix /, forward 80% of traffic to blue-svc and 20% to green-svc.
# 3. Add request header x-practice: cka to requests forwarded by that rule using
#    RequestHeaderModifier.
# 4. Rewrite PathPrefix /v1 to / while forwarding to blue-svc using URLRewrite
#    with ReplacePrefixMatch.
# 5. Redirect PathPrefix /legacy to /shop with HTTP status 302 using
#    RequestRedirect. The /legacy match is more specific than /, so it takes
#    precedence regardless of the order in which the rules are listed.
# 6. Inspect route rules, filters, weights, and status conditions.
#
# No data plane is installed; validate the Gateway API resources, not live traffic.
