variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_cidr" { type = string }
variable "enable_ipv6" { type = bool }
variable "availability_zones" { type = list(string) }
variable "cluster_name" { type = string }