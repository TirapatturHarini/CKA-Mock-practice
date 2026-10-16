# Question: Extract fields with kubectl custom-columns and --sort-by
#
# Deployments and Pods are ready in namespace jsonpath-lab.
#
# Tasks:
# 1. Show Pods as a custom table with NAME, APP, PHASE, NODE, CONTAINERS, and
#    IMAGES columns. Use JSONPath expressions for the column values.
# 2. Repeat without a header row and sort by Pod name.
# 3. Create a custom-columns file at ~/pod-columns.txt and use it to print the
#    namespace's Pods sorted by node name.
# 4. Show Deployments with NAME, DESIRED, READY, and IMAGE columns.
# 5. Show Pods from all namespaces with NAMESPACE and NAME columns, sorted by
#    namespace. Keep the output readable and explain that absent JSON fields may
#    display as <none>.
