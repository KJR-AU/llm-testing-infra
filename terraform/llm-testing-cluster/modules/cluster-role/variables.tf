variable "cluster_name" {
  description = "Name of the EKS cluster for naming the IAM role."
  type        = string
}

variable "role_name" {
  description = "Optional override for the IAM role name."
  type        = string
  default     = null
}
