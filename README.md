# CKA Practice (Simple Edition)

Straightforward CKA practice labs derived from the CKA-PREP playlist. Every question lives in its own folder with three bash files:

- `LabSetUp.bash` � copy/paste into Killercoda (or any Kubernetes cluster) to prep the environment.
- `Questions.bash` � the scenario text plus the YouTube link for the walkthrough.
- `SolutionNotes.bash` � a step-by-step solution when you need a hint.

## How to Use
1. Launch the CKA Killercoda playground or your own cluster.
2. Clone this repo inside the environment.
3. Pick a folder under `Question-*`.
4. Run `./scripts/run-question.sh Question-01` or cd ~/CKA-PREP-2025-v2
bash scripts/run-question.sh "Question-9 Network-Policy" to apply the setup and print the question text, or run `bash Question-01/LabSetUp.bash` manually.
5. Work through the task, then consult `SolutionNotes.bash` if you need help.

## Available Questions
| Question | Topic | Video |
|----------|-------|-------|
| Question-2 | Install Argo CD using Helm without CRDs | https://youtu.be/e0YGRSjb8CU |
| Question-18 | Helm repository search and chart installation | — |
| Question-19 | Helm values and release upgrade | — |
| Question-20 | Helm release history and rollback | — |
| Question-21 | Helm chart linting and template rendering | — |
| Question-22 | Helm release status, upgrade, and uninstall | — |
| Question-23 | Kustomize base, resources, namespace, and labels | — |
| Question-24 | Kustomize overlays for dev and production | — |
| Question-25 | Kustomize strategic-merge patches | — |
| Question-26 | Kustomize ConfigMap and Secret generators | — |
| Question-27 | Gateway and HTTPRoute fundamentals | — |
| Question-28 | HTTPRoute host/path/header/method matching | — |
| Question-29 | HTTPRoute filters and weighted backends | — |
| Question-30 | Cross-namespace routes and ReferenceGrant | — |
| Question-31 | Gateway TLS termination and HTTP redirect | — |
| Question-32 | Gateway listener route attachment with namespace selectors | — |

More questions can be added by copying the template folder and dropping in the three bash files from the original collection.

## Kustomize and Gateway API labs
Kustomize labs use `kubectl kustomize` and `kubectl apply -k`; their starter files are prepared under `~/cka-kustomize-*` by each lab setup script. Gateway API labs install the standard Gateway API CRDs and use a placeholder `GatewayClass` controller. They are designed to practice resource specifications, attachment, references, filters, and status inspection; a Gateway controller/data plane is not installed, so live HTTP routing is not expected.
