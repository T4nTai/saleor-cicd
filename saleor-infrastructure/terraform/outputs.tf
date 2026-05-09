output "vpc_id" {
  value = module.networking.vpc_id
}

output "cluster_name" {
  value = module.compute.cluster_name
}

output "cluster_endpoint" {
  value = module.compute.cluster_endpoint
}

output "configure_kubectl" {
  value = "aws eks update-kubeconfig --region us-east-1 --name ${module.compute.cluster_name}"
}

output "db_endpoint" {
  value     = module.data.db_endpoint
  sensitive = true
}

output "db_secret_arn" {
  value = module.security.db_password_secret_arn
}