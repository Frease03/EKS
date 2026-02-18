# Installs Argo CD via Helm. Run after kubeconfig is set.

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo/argo-cd --namespace argocd --create-namespace
