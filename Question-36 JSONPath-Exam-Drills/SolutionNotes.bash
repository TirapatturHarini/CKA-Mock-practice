NS=jsonpath-lab

# 1. Predicate filter plus range over matching Pods.
kubectl get pods -n "$NS" -l app=frontend \
  -o jsonpath='{range .items[?(@.status.phase=="Running")]}{.metadata.name}{"\n"}{end}'

# 2. Nested range prints each Pod and all its regular container images.
kubectl get pods -n "$NS" -l app=frontend \
  -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.nodeName}{"\t"}{range .spec.containers[*]}{.image}{" "}{end}{"\n"}{end}'

# 3. Index the init container array.
kubectl get pods -n "$NS" -l app=frontend \
  -o jsonpath='{.items[0].spec.initContainers[0].name}{"\t"}{.items[0].spec.initContainers[0].image}{"\n"}'

# 4. Sort by the resource field; custom-columns format the table.
kubectl get deployments -n "$NS" --sort-by=.metadata.name \
  -o 'custom-columns=NAME:.metadata.name,READY:.status.readyReplicas'

# 5. Node fields include maps; escape dots in qualified label keys.
kubectl get nodes \
  -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.addresses[?(@.type=="InternalIP")].address}{"\t"}{.status.capacity.cpu}{"\t"}{.metadata.labels.kubernetes\.io/hostname}{"\n"}{end}'

# 6. Cluster-wide selection and ordering.
kubectl get pods -A --sort-by=.metadata.namespace \
  -o jsonpath='{range .items[*]}{.metadata.namespace}{"/"}{.metadata.name}{"\n"}{end}'
