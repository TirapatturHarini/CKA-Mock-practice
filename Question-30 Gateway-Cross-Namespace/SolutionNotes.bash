cat <<'EOF' > edge-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: edge-gateway
  namespace: edge
spec:
  gatewayClassName: cka-gateway-class
  listeners:
    - name: edge-http
      protocol: HTTP
      port: 80
EOF
kubectl apply -f edge-gateway.yaml

cat <<'EOF' > reference-grant.yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: ReferenceGrant
metadata:
  name: allow-edge-route-to-store
  namespace: apps
spec:
  from:
    - group: gateway.networking.k8s.io
      kind: HTTPRoute
      namespace: edge
  to:
    - group: ""
      kind: Service
      name: store-svc
EOF
kubectl apply -f reference-grant.yaml

cat <<'EOF' > store-route.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: store-route
  namespace: edge
spec:
  parentRefs:
    - name: edge-gateway
      sectionName: edge-http
  hostnames:
    - store.example.test
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: store-svc
          namespace: apps
          port: 80
EOF
kubectl apply -f store-route.yaml
kubectl get referencegrant -n apps
kubectl describe httproute store-route -n edge
