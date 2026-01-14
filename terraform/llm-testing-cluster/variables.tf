variable "backend_bucket" {
  description = "THe bucket to write the state file to"
  type        = string
}

variable "backend_key" {
  description = "The key to write the state file to"
  type        = string
}


variable "region_name" {
  description = "The name of the AWS region to deploy into"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version of the EKS cluster"
  type        = string
}

variable "cluster_addon_version_coredns" {
  description = "The version of the CoreDNS addon"
  type        = string
}

variable "cluster_addon_version_metrics_server" {
  description = "The version of the Metrics Server addon"
  type        = string
}

variable "cluster_addon_version_kube_proxy" {
  description = "The version of the kube-proxy addon"
  type        = string
}
variable "cluster_addon_version_vpc_cni" {
  description = "The version of the Amazon VPC CNI addon"
  type        = string
}

variable "cluster_addon_version_node_monitoring" {
  description = "The version of the node monitoring agent addon"
  type        = string
}

variable "cluster_addon_version_ebs_csi" {
  description = "The version of the EBS CSI driver addon"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "vpc_azs" {
  description = "Availability zones for the VPC subnets."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
}

variable "api_public_access_cidrs" {
  description = "CIDR blocks allowed to reach the EKS public API endpoint."
  type        = list(string)
}

# Dagster system node group variables
variable "phoenix_desired_size" {
  description = "The desired size of the phoenix EKS node group"
  type        = number
}

variable "phoenix_max_size" {
  description = "The maximum size of the phoenix EKS node group"
  type        = number
}

variable "phoenix_min_size" {
  description = "The minimum size of the phoenix EKS node group"
  type        = number
}

variable "phoenix_instance_type" {
  description = "The instance type for the phoenix EKS node group"
  type        = string
}

variable "phoenix_disk_size" {
  description = "The disk size for the phoenix EKS node group instances"
  type        = number
}

variable "phoenix_ssh_key" {
  description = "The SSH key name for accessing the phoenix EKS node group instances"
  type        = string
}
