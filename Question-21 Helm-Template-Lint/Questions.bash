# Question: Validate and render a Helm chart without installing it
#
# A local chart is available at ~/cka-helm-chart. Your task is to check the chart
# and generate manifests for release web in namespace helm-template.
#
# Tasks:
# 1. Run Helm's chart linter and inspect the chart metadata.
# 2. Render the chart with 3 replicas and save the manifests to
#    ~/rendered-web.yaml.
# 3. Confirm the output contains a Deployment with 3 replicas and a Service.
# 4. Confirm no Helm release or workload was installed in the cluster.
