provider "aws" {
  region = var.region_name
}

module "vpc" {
  source = "./modules/vpc"

  name                 = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.vpc_azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "llm_testing_cluster_role" {
  source       = "./modules/cluster-role"
  cluster_name = var.cluster_name
  role_name    = "llm-testing-cluster-role"
}

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = module.llm_testing_cluster_role.role_arn

  vpc_config {
    subnet_ids              = module.vpc.private_subnet_ids
    endpoint_public_access  = true
    endpoint_private_access = false
    public_access_cidrs     = var.api_public_access_cidrs
  }
}

data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}



resource "aws_eks_addon" "cluster_addon_node_monitoring" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "eks-node-monitoring-agent"
  addon_version               = var.cluster_addon_version_node_monitoring
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "cluster_addon_metrics_server" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "metrics-server"
  addon_version               = var.cluster_addon_version_metrics_server
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "cluster_addon_coredns" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "coredns"
  addon_version               = var.cluster_addon_version_coredns
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "cluster_addon_kube_proxy" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "kube-proxy"
  addon_version               = var.cluster_addon_version_kube_proxy
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "cluster_addon_vpc_cni" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "vpc-cni"
  addon_version               = var.cluster_addon_version_vpc_cni
  resolve_conflicts_on_update = "PRESERVE"
}

# Node group for Phoenix otel platform
module "phoenix" {
  source          = "./modules/phoenix"
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "phoenix"
  role_name       = "llm-testing-node-group-role-phoenix"

  subnet_ids   = module.vpc.private_subnet_ids
  desired_size = var.phoenix_desired_size
  max_size     = var.phoenix_max_size
  min_size     = var.phoenix_min_size

  instance_type = var.phoenix_instance_type
  disk_size     = var.phoenix_disk_size
  ssh_key       = var.phoenix_ssh_key
}
