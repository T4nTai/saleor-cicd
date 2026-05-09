resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public[*].id

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no         = 101
    action          = "allow"
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    ipv6_cidr_block = "::/0"
  }

  ingress {
    rule_no    = 110
    action     = "allow"
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no         = 111
    action          = "allow"
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    ipv6_cidr_block = "::/0"
  }

  ingress {
    rule_no    = 120
    action     = "allow"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no         = 101
    action          = "allow"
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    ipv6_cidr_block = "::/0"
  }

  tags = { Name = "${var.project_name}-public-nacl" }
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_block = var.vpc_cidr
  }

  ingress {
    rule_no    = 110
    action     = "allow"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 120
    action     = "allow"
    protocol   = "tcp"
    from_port  = 5432
    to_port    = 5432
    cidr_block = var.vpc_cidr
  }

  ingress {
    rule_no    = 130
    action     = "allow"
    protocol   = "tcp"
    from_port  = 10250
    to_port    = 10250
    cidr_block = var.vpc_cidr
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no         = 101
    action          = "allow"
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    ipv6_cidr_block = "::/0"
  }

  tags = { Name = "${var.project_name}-private-nacl" }
}