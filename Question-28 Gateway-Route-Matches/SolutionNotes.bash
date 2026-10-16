cat <<'EOF' > app-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: app-gateway
  namespace: gw-matches
spec:
  gatewayClassName: cka-gateway-class
  listeners:
    - name: app-http
      protocol: HTTP
      port: 80
      hostname: apps.example.test
EOF
kubectl apply -f app-gateway.yaml

cat <<'EOF' > app-route.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: app-route
  namespace: gw-matches
spec:
  parentRefs:
    - name: app-gateway
      sectionName: app-http
  hostnames:
    - apps.example.test
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /api
          method: GET
          headers:
            - type: Exact
              name: x-version
              value: beta
          queryParams:
            - type: Exact
              name: format
              value: json
      backendRefs:
        - name: api-svc
          port: 80
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: web-svc
          port: 80
EOF
kubectl apply -f app-route.yaml
kubectl describe httproute app-route -n gw-matches
