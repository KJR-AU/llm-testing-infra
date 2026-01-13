variable "cluster_name" {
  description = "Name of the EKS cluster to prefix IAM role resources."
  type        = string
}

variable "role_name" {
  description = "Optional explicit name for the node group IAM role."
  type        = string
  default     = null
}
