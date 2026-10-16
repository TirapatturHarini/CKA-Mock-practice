# Question: Configure TLS termination and HTTP-to-HTTPS redirect
#
# Namespace gw-tls contains secure-web-svc and TLS Secret secure-web-tls for
# secure.example.test. Gateway API CRDs and placeholder GatewayClass are installed.
#
# Tasks:
# 1. Create Gateway secure-gateway with HTTPS listener secure-https on port 443,
#    hostname secure.example.test, TLS mode Terminate, using secure-web-tls.
# 2. Create HTTPRoute secure-route attached specifically to listener secure-https
#    and route PathPrefix / to secure-web-svc port 80.
# 3. Add an HTTP listener secure-http on port 80 and create redirect-route attached
#    to that listener. Redirect all paths to https using status code 301.
# 4. Inspect listener, certificateRef, parentRefs.sectionName, and route conditions.
#
# No Gateway controller/data plane is installed, so verify resource configuration only.
