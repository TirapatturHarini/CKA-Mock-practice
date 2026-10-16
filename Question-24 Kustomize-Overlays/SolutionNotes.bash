cd ~/cka-kustomize-overlays
cat <<'EOF' > overlays/dev/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../../base
namespace: kustomize-dev
namePrefix: dev-
replicas:
  - name: web
    count: 1
images:
  - name: nginx
    newTag: 1.27.4
EOF

cat <<'EOF' > overlays/prod/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../../base
namespace: kustomize-prod
namePrefix: prod-
replicas:
  - name: web
    count: 4
images:
  - name: nginx
    newTag: 1.27.5
EOF

# Preview and apply each environment independently.
kubectl kustomize overlays/dev
kubectl kustomize overlays/prod
kubectl apply -k overlays/dev
kubectl apply -k overlays/prod
kubectl get deployment,service -n kustomize-dev -o wide
kubectl get deployment,service -n kustomize-prod -o wide
