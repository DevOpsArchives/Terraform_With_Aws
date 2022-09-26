data "aws_region" "this" {}

########################## VPC ##########################
resource "aws_vpc" "vpc_basic" {
  count            = var.vpc_mode == "vpc_baisc" ? 1 : 0
  cidr_block       = var.cird_range
  instance_tenancy = "default"

  tags = {
    Name    = var.vpc_name
    Billing = var.vpc_name
  }
}
########################## VPC ##########################


########################## VPC With IPAM ##########################
resource "aws_vpc_ipam" "ipam" {
  count = var.vpc_mode == "vpc_ipam" ? 1 : 0
  operating_regions {
    region_name = data.aws_region.this.name
  }
}

resource "aws_vpc_ipam_pool" "vpc_ipam_pool" {
  count          = var.vpc_mode == "vpc_ipam" ? 1 : 0
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.ipam[count.index].private_default_scope_id
  locale         = data.aws_region.this.name
}

resource "aws_vpc_ipam_pool_cidr" "vpc_ipam_pool_cidr" {
  count        = var.vpc_mode == "vpc_ipam" ? 1 : 0
  ipam_pool_id = aws_vpc_ipam.ipam[count.index].id
  cidr         = var.cird_range
}

resource "aws_vpc" "vpc_ipam" {
  count               = var.vpc_mode == "vpc_ipam" ? 1 : 0
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.vpc_ipam_pool[count.index].id
  ipv4_netmask_length = 28
  depends_on = [
    aws_vpc_ipam_pool_cidr.vpc_ipam_pool_cidr
  ]

  tags = {
    Name    = var.vpc_name
    Billing = var.vpc_name
  }
}
########################## VPC With IPAM ##########################
