variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "saleor"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "VPC IPv4 CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_ipv6" {
  description = "Enable dual stack IPv4/IPv6"
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "saleor-eks-cluster"
}

variable "cluster_version" {
  description = "EKS version"
  type        = string
  default     = "1.32"
}

variable "node_instance_type" {
  description = "Worker node instance type"
  type        = string
  default     = "t3.small"
}

variable "node_desired_size" {
  type    = number
  default = 1
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 2
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "saleor"
}

variable "devops_key_name" {
  description = "EC2 Key Pair name cho DevOps tools server"
  type        = string
  default     = ""
}

variable "your_ip_cidr" {
  description = "IP của bạn để SSH vào EC2, ví dụ: 1.2.3.4/32"
  type        = string
  default     = "0.0.0.0/0"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "saleor_admin"
  sensitive   = true
}
