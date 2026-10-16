cat <<'EOF' > shared-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: shared-gateway
  namespace: infra
spec:
  gatewayClassName: cka-gateway-class
  listeners:
    - name: shared-http
      protocol: HTTP
      port: 80
      hostname: team.example.test
      allowedRoutes:
        kinds:
          - kind: HTTPRoute
        namespaces:
          from: Selector
          selector:
            matchLabels:
              gateway-access: enabled
EOF
kubectl apply -f shared-gateway.yaml

cat <<'EOF' > team-route.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: team-route
  namespace: tenant-blue
spec:
  parentRefs:
    - name: shared-gateway
      namespace: infra
      sectionName: shared-http
  hostnames:
    - team.example.test
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: team-web-svc
          port: 80
EOF
kubectl apply -f team-route.yaml
kubectl get namespace tenant-blue tenant-red --show-labels
kubectl get gateway shared-gateway -n infra -o yaml
kubectl get httproute team-route -n tenant-blue -o yaml
