NS=jsonpath-lab

# Filter list items by a field predicate.
kubectl get pods -n "$NS" -o jsonpath='{range .items[?(@.status.phase=="Running")]}{.metadata.name}{"\n"}{end}'

# Filter by a label, then filter a nested containers array by name.
kubectl get pods -n "$NS" -o jsonpath='{range .items[?(@.metadata.labels.app=="frontend")]}{.metadata.name}{"\n"}{end}'
kubectl get pods -n "$NS" -l app=frontend -o jsonpath='{range .items[*]}{.metadata.name}{": "}{range .spec.containers[?(@.name=="nginx")]}{.name}{"="}{.image}{end}{"\n"}{end}'

# Explicit root ($), bracket notation, slices, and negative indexes.
kubectl get pods -n "$NS" -o jsonpath='{$.items[0]["metadata"]["name"]}{"\n"}'
kubectl get pods -n "$NS" -o jsonpath='{$.items[0:2].metadata.name}{"\n"}'
kubectl get pods -n "$NS" -o jsonpath='{$.items[-1].metadata.name}{"\n"}'

# Nested arrays: initContainers and containers are separate lists.
kubectl get pods -n "$NS" -l app=frontend -o jsonpath='{range .items[*]}{.metadata.name}{"\tinit="}{range .spec.initContainers[*]}{.image}{" "}{end}{"\tcontainers="}{range .spec.containers[*]}{.name}{" "}{end}{"\n"}{end}'

# Dots in qualified label/annotation keys must be escaped in JSONPath.
kubectl get configmap app-settings -n "$NS" -o jsonpath='{.metadata.labels.example\.com/team}{"\n"}'
kubectl get pods -n "$NS" -l app=frontend -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.annotations.example\.com/owner}{"\n"}{end}'

# Kubernetes commonly labels Nodes with kubernetes.io/hostname.
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.kubernetes\.io/hostname}{"\n"}{end}'
