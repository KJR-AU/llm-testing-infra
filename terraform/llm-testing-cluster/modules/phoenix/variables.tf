variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "node_group_name" {
  description = "Name for the Phoenix node group."
  type        = string
  default     = "phoenix"
}

variable "role_name" {
  description = "Optional explicit IAM role name for the node group."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Subnet IDs where the node group will run."
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of nodes."
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes."
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes."
  type        = number
}

variable "instance_type" {
  description = "Instance type for the node group."
  type        = string
}

variable "disk_size" {
  description = "Disk size (GB) for nodes."
  type        = number
}

variable "ssh_key" {
  description = "EC2 key pair name for SSH access."
  type        = string
}
