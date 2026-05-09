output "eks_sg_id" {
  value = aws_security_group.eks_cluster.id
}

output "eks_nodes_sg_id" {
  value = aws_security_group.eks_nodes.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "db_password_secret_arn" {
  value = aws_secretsmanager_secret.db_password.arn
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}