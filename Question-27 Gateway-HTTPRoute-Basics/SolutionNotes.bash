cat <<'EOF' > gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: web-gateway
  namespace: gw-basic
spec:
  gatewayClassName: cka-gateway-class
  listeners:
    - name: web-http
      protocol: HTTP
      port: 80
      hostname: app.example.test
EOF
kubectl apply -f gateway.yaml

cat <<'EOF' > route.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: web-route
  namespace: gw-basic
spec:
  parentRefs:
    - name: web-gateway
      sectionName: web-http
  hostnames:
    - app.example.test
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: web-svc
          port: 80
EOF
kubectl apply -f route.yaml
kubectl get gateway,httproute -n gw-basic -o yaml
