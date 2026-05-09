variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  description = "Public subnet để EC2 có public IP"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name để SSH (tạo trước trên AWS Console)"
  type        = string
  default     = ""
}

variable "your_ip_cidr" {
  description = "IP của bạn để mở SSH, ví dụ: 1.2.3.4/32"
  type        = string
  default     = "0.0.0.0/0"
}
