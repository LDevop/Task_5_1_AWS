# Creating a VPC!
resource "aws_vpc" "custom" {

  # IP Range for the VPC
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "custom"
  }
}

# data "aws_availability_zones" "available" {
#   state = "available"
# }

# output "az_c" {
#   value = data.aws_availability_zones.available.names[2]
# }