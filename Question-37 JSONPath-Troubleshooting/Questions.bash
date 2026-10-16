# Question: Diagnose and repair JSONPath field expressions
#
# Use resources in namespace jsonpath-lab. Each expression below has a common
# mistake. Correct the expression and explain the failure.
#
# Broken attempts:
# - kubectl get pods -n jsonpath-lab -o=jsonpath='{.metadata.name}'
# - kubectl get pods -n jsonpath-lab -o=jsonpath='{range .items[*]}{.metadata.name}{\\n}{end}'
# - kubectl get configmap app-settings -n jsonpath-lab -o=jsonpath='{.metadata.labels.example.com/team}'
# - kubectl get pods -n jsonpath-lab -o=jsonpath='{NAME:.metadata.name,IMAGE:.spec.containers[*].image}'
#
# Tasks:
# 1. Fix the expression that lists Pod names from a list response.
# 2. Fix the expression that prints each Pod on a separate line (including the
#    literal newline syntax).
# 3. Fix access to the example.com/owner annotation and example.com/team label.
# 4. Fix a custom-columns command so it shows Pod name and image, rather than
#    treating the whole custom-columns definition as a JSONPath template.
# 5. Use kubectl get ... -o yaml/json to discover the correct path before editing.
#
# Common traps to look for: missing .items on list responses, an unescaped dot in
# qualified keys, missing braces around JSONPath template, and incorrect quoting.
