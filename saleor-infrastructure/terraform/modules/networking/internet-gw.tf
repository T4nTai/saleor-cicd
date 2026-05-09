resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.project_name}-igw" }
}

resource "aws_egress_only_internet_gateway" "eigw" {
  count  = var.enable_ipv6 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.project_name}-eigw" }
}