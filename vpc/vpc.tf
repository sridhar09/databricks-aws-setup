//The AWS VPC is registered as the databricks_mws_networks resource.
data "aws_availability_zones" "available" {}
data "aws_caller_identity" "local" {}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = merge(var.default_tags, {
    Name = "${var.prefix}-databricks-vpc"
  })
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 3, 0)
  availability_zone = "${var.aws_region}a"

  tags = merge(var.default_tags, {
    Name = "${var.prefix}-databricks-public-sn"
  })
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 3, 1)
  availability_zone = "${var.aws_region}a"

  tags = merge(var.default_tags, {
    Name = "${var.prefix}-databricks-private-sn"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.default_tags, {
    Name = "${var.prefix}-databricks-igw"
  })
}

resource "aws_route" "default" {
  route_table_id         = aws_vpc.main.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_vpc_endpoint" "sts" {
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.aws_region}.sts"
  subnet_ids          = [aws_subnet.public.id]
  security_group_ids = [
    aws_security_group.databricks-sg.id
  ]
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.main.id
  tags = merge(var.default_tags, {
    Name = "sts-vpc-endpoint"
  })
}

resource "aws_security_group" "databricks-sg" {
  name        = "databricks-security-group"
  description = "Security Group for databricks"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    description = "Referring to same sg"
    self        = true
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "UDP"
    description = "Referring to same sg"
    self        = true
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
  }
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "databricks hive"
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    description = "Referring to same sg"
    self        = true
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "UDP"
    description = "Referring to same sg"
    self        = true
  }
  tags = var.default_tags
}
