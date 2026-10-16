# Question: Advanced kubectl JSONPath expressions
#
# Use the fixtures in namespace jsonpath-lab. Solve each task with JSONPath filters,
# nested range blocks, and escaped map keys. Do not use jq or a scripting language.
#
# Tasks:
# 1. List only Pods whose phase is Running using a filter predicate.
# 2. List names of frontend Pods whose app label is frontend; then list only
#    container names/images where the container name is nginx.
# 3. For each frontend Pod, print its name, init-container image(s), and regular
#    container names in a readable multi-column format using nested range/end.
# 4. Use an explicit root and bracket notation to print a Pod name; use a slice to
#    print the first two names in the list. Try a negative index as well.
# 5. Read the example.com/team ConfigMap label and example.com/owner Pod-template
#    annotation. Escape the dot in the qualified key.
# 6. Print each Node's name and host name label. If the node label key is absent
#    on your cluster, explain how the escaped-key expression works.
#
# Note: Kubernetes JSONPath supports range/end, filters, wildcards and negative
# indexes (when in bounds); it is not a full implementation of every JSONPath library.
