output "public_ip" {
  value       = aws_eip.devops_tools.public_ip
  description = "Elastic IP của EC2"
}

output "sonarqube_url" {
  value       = "http://${aws_eip.devops_tools.public_ip}:9000"
  description = "SonarQube UI — default login: admin/admin"
}

output "vault_url" {
  value       = "http://${aws_eip.devops_tools.public_ip}:8200"
  description = "Vault UI + API address"
}
