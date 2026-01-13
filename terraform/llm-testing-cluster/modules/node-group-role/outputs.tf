output "role_name" {
  description = "IAM role name for the managed node group."
  value       = aws_iam_role.node_group_role.name
}

output "role_arn" {
  description = "IAM role ARN for the managed node group."
  value       = aws_iam_role.node_group_role.arn
}
