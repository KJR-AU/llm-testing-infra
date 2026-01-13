# Single-Node EKS with Terraform

This Terraform project provisions an EKS cluster with a single managed node along with the supporting VPC, subnets, and IAM resources.

## Prerequisites
- Terraform `>= 1.5`
- AWS credentials with permissions for EKS, VPC, IAM, and EC2
- `kubectl` and `awscli` for interacting with the cluster

## Usage
1. Change into the project directory:
   ```bash
   cd terraform/eks-single-node
   ```
2. (Optional) Override defaults in `terraform.tfvars`:
   ```hcl
   aws_region        = "us-east-1"
   project           = "my-project"
   environment       = "dev"
   cluster_version   = "1.28"
   node_instance_type = "t3.medium"
   ```
3. Initialize and review the plan:
   ```bash
   terraform init
   terraform plan -out plan.tfplan
   ```
4. Apply the plan:
   ```bash
   terraform apply plan.tfplan
   ```
5. Configure `kubectl`:
   ```bash
   aws eks update-kubeconfig --name "$(terraform output -raw cluster_name)" --region "$(terraform output -raw region)"
   ```

## Notes
- The configuration uses two AZs with public and private subnets; the single managed node group runs in the private subnets.
- NAT Gateway is enabled (single AZ) for worker egress; adjust or disable if cost-sensitive.
- Scale the node group by changing `desired_size`, `min_size`, and `max_size` in `main.tf`.
- Destroy when done to avoid charges:
  ```bash
  terraform destroy
  ```
