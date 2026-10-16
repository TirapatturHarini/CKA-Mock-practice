cd ~/cka-kustomize-patches
cat <<'EOF' > kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: kustomize-patch
resources:
  - deployment.yaml
patches:
  - path: patches/payments.yaml
EOF

kubectl kustomize .
kubectl apply -k .
kubectl get deployment payments -n kustomize-patch -o wide
kubectl describe deployment payments -n kustomize-patch
