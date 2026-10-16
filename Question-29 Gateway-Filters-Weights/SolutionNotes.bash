cat <<'EOF' > shop-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: shop-gateway
  namespace: gw-filters
spec:
  gatewayClassName: cka-gateway-class
  listeners:
    - name: shop-http
      protocol: HTTP
      port: 80
      hostname: shop.example.test
EOF
kubectl apply -f shop-gateway.yaml

cat <<'EOF' > shop-route.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: shop-route
  namespace: gw-filters
spec:
  parentRefs:
    - name: shop-gateway
      sectionName: shop-http
  hostnames:
    - shop.example.test
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /v1
      filters:
        - type: URLRewrite
          urlRewrite:
            path:
              type: ReplacePrefixMatch
              replacePrefixMatch: /
      backendRefs:
        - name: blue-svc
          port: 80
    - matches:
        - path:
            type: PathPrefix
            value: /legacy
      filters:
        - type: RequestRedirect
          requestRedirect:
            path:
              type: ReplaceFullPath
              replaceFullPath: /shop
            statusCode: 302
    - matches:
        - path:
            type: PathPrefix
            value: /
      filters:
        - type: RequestHeaderModifier
          requestHeaderModifier:
            add:
              - name: x-practice
                value: cka
      backendRefs:
        - name: blue-svc
          port: 80
          weight: 80
        - name: green-svc
          port: 80
          weight: 20
EOF
kubectl apply -f shop-route.yaml
kubectl describe httproute shop-route -n gw-filters
