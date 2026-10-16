# Question: Basic kubectl JSONPath field extraction
#
# The namespace jsonpath-lab contains frontend and api workloads, Services,
# a ConfigMap, and a Secret. Use kubectl JSONPath output rather than jq.
#
# Tasks:
# 1. Print the namespace's Pod names as one space-separated line.
# 2. Print each Pod name and phase on its own line using range/end and a newline
#    literal. Include tabs between columns.
# 3. Print the first and last Pod names using list indexes, then print all
#    container names and images for the frontend Pods.
# 4. Print the frontend Deployment's desired replicas, current replicas, and
#    ready replicas on one line.
# 5. Print the Service's ClusterIP and its first service port.
#
# Use `kubectl get ... -o jsonpath=...`; JSONPath templates are case-sensitive.
