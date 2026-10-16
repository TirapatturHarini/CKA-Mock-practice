# Question: CKA JSONPath and custom-columns timed drills
#
# Complete these without jq. Work from namespace jsonpath-lab, then use Nodes and
# all namespaces where requested. Prefer concise kubectl commands.
#
# Tasks:
# 1. Print frontend Pod names that are Running, one per line.
# 2. Print each frontend Pod's name, node, and comma/space-separated container
#    images using JSONPath range blocks.
# 3. Print the first frontend Pod's init-container name and image.
# 4. Print Deployment names and ready replica counts, sorted by name, using
#    custom-columns.
# 5. Print each Node's name, InternalIP, CPU capacity, and
#    kubernetes.io/hostname label using JSONPath; print a tab between fields.
# 6. Print all Pods across namespaces as namespace/name, sorted by namespace.
# 7. Identify which output flag is appropriate for each task: -o jsonpath,
#    -o custom-columns, or --sort-by. Explain the key syntax difference between
#    a JSONPath template and a custom-columns field path.
#
# Exam reminder: JSONPath supports template braces and range/end; custom-columns
# uses HEADER:JSONPath field-path pairs and is usually the fastest way to build a
# readable table. Always inspect the actual resource with kubectl get -o yaml/json
# before guessing a field path.
