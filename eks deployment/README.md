# EKS Deployment with Terraform

This project provisions an Amazon EKS cluster with a VPC, managed node group, and baseline platform add-ons.

## Prerequisites
- AWS CLI configured (`aws configure`)
- Terraform >= 1.5
- kubectl installed

## Quick Start
1. Initialize Terraform
   ```powershell
   terraform init
   ```
2. Review the plan
   ```powershell
   terraform plan
   ```
3. Apply
   ```powershell
   terraform apply
   ```

## Configure kubectl
After apply, run:
```powershell
aws eks update-kubeconfig --region <region> --name <cluster_name>
```

## What Terraform Installs
- Argo CD
- Metrics Server
- Cert-Manager (with CRDs)
- AWS Load Balancer Controller
- EBS CSI Driver add-on

## Version Pinning
- Helm chart versions are pinned in `variables.tf`.
- EBS CSI add-on uses the most recent AWS-tested version for your Kubernetes version at plan/apply time.

## Access Argo CD UI
1. Port-forward the server
   ```powershell
   kubectl -n argocd port-forward svc/argocd-server 8080:80
   ```
2. Get the initial admin password
   ```powershell
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | %{ [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($_)) }
   ```
3. Open `http://localhost:8080` and log in with `admin` and the password above.

## Sample Application
Apply the sample app:
```powershell
kubectl apply -f k8s/argocd/apps/guestbook.yaml
```

## Destroy
```powershell
terraform destroy
```
