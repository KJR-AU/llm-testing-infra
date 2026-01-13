output "role_name" {
  description = "IAM role name for the EKS control plane."
  value       = aws_iam_role.cluster_role.name
}

output "role_arn" {
  description = "IAM role ARN for the EKS control plane."
  value       = aws_iam_role.cluster_role.arn
}
