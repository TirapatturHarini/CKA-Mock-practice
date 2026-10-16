NS=jsonpath-lab

# Lists expose their objects under .items; wildcard selects each item.
kubectl get pods -n "$NS" -o jsonpath='{.items[*].metadata.name}{"\n"}'

# range/end iterates array items; quoted literals print delimiters/newlines.
kubectl get pods -n "$NS" -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.phase}{"\n"}{end}'

# Index access and nested array traversal.
kubectl get pods -n "$NS" -o jsonpath='{.items[0].metadata.name}{"\n"}'
kubectl get pods -n "$NS" -o jsonpath='{.items[-1].metadata.name}{"\n"}'
kubectl get pods -n "$NS" -l app=frontend -o jsonpath='{range .items[*]}{.metadata.name}{": "}{range .spec.containers[*]}{.name}{"="}{.image}{" "}{end}{"\n"}{end}'

# Direct field access on a single named resource.
kubectl get deployment frontend -n "$NS" -o jsonpath='{.spec.replicas}{" desired, "}{.status.replicas}{" current, "}{.status.readyReplicas}{" ready\n"}'
kubectl get service frontend -n "$NS" -o jsonpath='{.spec.clusterIP}{" port="}{.spec.ports[0].port}{"\n"}'
