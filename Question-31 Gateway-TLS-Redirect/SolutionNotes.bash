cat <<'EOF' > secure-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: secure-gateway
  namespace: gw-tls
spec:
  gatewayClassName: cka-gateway-class
  listeners:
    - name: secure-http
      protocol: HTTP
      port: 80
      hostname: secure.example.test
    - name: secure-https
      protocol: HTTPS
      port: 443
      hostname: secure.example.test
      tls:
        mode: Terminate
        certificateRefs:
          - kind: Secret
            name: secure-web-tls
EOF
kubectl apply -f secure-gateway.yaml

cat <<'EOF' > secure-route.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: secure-route
  namespace: gw-tls
spec:
  parentRefs:
    - name: secure-gateway
      sectionName: secure-https
  hostnames:
    - secure.example.test
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: secure-web-svc
          port: 80
EOF
kubectl apply -f secure-route.yaml

cat <<'EOF' > redirect-route.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: redirect-route
  namespace: gw-tls
spec:
  parentRefs:
    - name: secure-gateway
      sectionName: secure-http
  hostnames:
    - secure.example.test
  rules:
    - filters:
        - type: RequestRedirect
          requestRedirect:
            scheme: https
            statusCode: 301
EOF
kubectl apply -f redirect-route.yaml
kubectl get gateway,httproute -n gw-tls -o yaml
