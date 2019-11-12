data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

