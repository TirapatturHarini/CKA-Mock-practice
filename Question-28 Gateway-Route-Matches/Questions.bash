# Question: Match HTTPRoute traffic by host, path, header, and method
#
# Gateway API CRDs, a placeholder GatewayClass, and web/api Services are ready in
# namespace gw-matches. Create a Gateway named app-gateway with HTTP listener
# app-http on port 80 and hostname apps.example.test.
#
# Tasks:
# 1. Create HTTPRoute app-route attached to app-gateway section app-http.
# 2. Route GET requests with path prefix /api, header x-version: beta, and query
#    parameter format=json to api-svc. All fields in one match must match together.
# 3. Route all other requests with path prefix / to web-svc.
# 4. Verify hostnames, parentRefs, match fields, and backendRefs in the route spec.
#
# Remember: conditions within one match are ANDed; separate matches are alternatives.
# This environment has no Gateway data plane, so use manifest/status inspection.
