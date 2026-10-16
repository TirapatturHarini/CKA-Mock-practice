NS=jsonpath-lab

# List response fields are under .items; singleton fields are under .metadata.
kubectl get pods -n "$NS" -o jsonpath='{.items[*].metadata.name}{"\n"}'

# Newline/tab are JSONPath string literals inside braces.
kubectl get pods -n "$NS" -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.phase}{"\n"}{end}'

# Escape dots in qualified map keys; keep the slash as part of the key.
kubectl get pods -n "$NS" -l app=frontend \
  -o jsonpath='{range .items[*]}{.metadata.annotations.example\.com/owner}{"\n"}{end}'
kubectl get configmap app-settings -n "$NS" \
  -o jsonpath='{.metadata.labels.example\.com/team}{"\n"}'

# custom-columns is its own output format; no JSONPath template braces are used.
kubectl get pods -n "$NS" \
  -o 'custom-columns=NAME:.metadata.name,IMAGE:.spec.containers[*].image'

# Inspect complete objects whenever unsure of the correct field paths.
kubectl get pod -n "$NS" -l app=frontend -o yaml
kubectl get pod -n "$NS" -l app=frontend -o json
