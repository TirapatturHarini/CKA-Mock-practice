cd ~/cka-kustomize-base
cat <<'EOF' > kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: kustomize-base
resources:
  - deployment.yaml
  - service.yaml
commonLabels:
  team: platform
EOF

# Preview, apply, and verify the transformed resources.
kubectl kustomize .
kubectl apply -k .
kubectl get deployment,service -n kustomize-base --show-labels
