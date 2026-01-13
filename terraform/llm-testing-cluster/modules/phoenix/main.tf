module "phoenix_node_group_role" {
  source       = "../node-group-role"
  cluster_name = var.cluster_name
  role_name    = var.role_name
}

resource "aws_eks_node_group" "phoenix" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = module.phoenix_node_group_role.role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]
  disk_size      = var.disk_size

  node_repair_config {
    enabled = true
  }

  remote_access {
    ec2_ssh_key = var.ssh_key
  }

  labels = {
    nodegroup = "phoenix"
  }

  tags = {
    Name = "phoenix"
  }
}
