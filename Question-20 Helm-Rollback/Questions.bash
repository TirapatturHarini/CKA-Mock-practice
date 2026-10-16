# Question: Roll back a Helm release
#
# Release web in namespace helm-rollback has been upgraded and is currently
# configured with 4 replicas. The earlier revision had 1 replica.
#
# Tasks:
# 1. Inspect the release history and identify the revision with 1 replica.
# 2. Roll release web back to that revision.
# 3. Verify the current revision, effective values, and Deployment replica count.
#
# Do not uninstall or reinstall the release.
