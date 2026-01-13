output "node_group_name" {
  description = "Name of the Phoenix node group."
  value       = aws_eks_node_group.phoenix.node_group_name
}

output "node_role_arn" {
  description = "IAM role ARN used by the Phoenix node group."
  value       = module.phoenix_node_group_role.role_arn
}

output "node_role_name" {
  description = "IAM role name used by the Phoenix node group."
  value       = module.phoenix_node_group_role.role_name
}
