cd ~/cka-kustomize-generators
cat <<'EOF' > kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: kustomize-generated
resources:
  - deployment.yaml
configMapGenerator:
  - name: catalog-settings
    literals:
      - LOG_LEVEL=debug
      - FEATURE_SEARCH=true
secretGenerator:
  - name: catalog-credentials
    literals:
      - username=catalog
      - password=practice-only
EOF

# Hash suffixes are enabled by default; Kustomize updates pod references.
kubectl kustomize .
kubectl apply -k .
kubectl get deployment,configmap,secret -n kustomize-generated
kubectl describe deployment catalog -n kustomize-generated
