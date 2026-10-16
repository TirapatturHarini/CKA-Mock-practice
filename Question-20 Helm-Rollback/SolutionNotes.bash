# Review revisions and their chart values.
helm history web --namespace helm-rollback
helm get values web --namespace helm-rollback --all

# Revision 1 is the original release with replicaCount=1.
helm rollback web 1 --namespace helm-rollback

# Verify rollback created a new current revision and restored one replica.
helm history web --namespace helm-rollback
helm get values web --namespace helm-rollback --all
kubectl get deployment web --namespace helm-rollback
