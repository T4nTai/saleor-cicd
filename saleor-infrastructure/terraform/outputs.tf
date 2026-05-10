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
  value = "aws eks update-kubeconfig --region ap-southeast-1 --name ${module.compute.cluster_name}"
}

output "db_endpoint" {
  value     = module.data.db_endpoint
  sensitive = true
}

output "db_secret_arn" {
  value = module.security.db_password_secret_arn
}

output "sonarqube_url" {
  value = module.devops_tools.sonarqube_url
}

output "vault_url" {
  value = module.devops_tools.vault_url
}

output "devops_tools_ip" {
  value = module.devops_tools.public_ip
}