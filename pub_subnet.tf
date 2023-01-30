# Creating Public subnet!
resource "aws_subnet" "public" {
  count = length(var.subnet_cidrs_public)
  depends_on = [
    aws_vpc.custom
  ]
  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id

  # IP Range of this subnet
  cidr_block = element(var.subnet_cidrs_public, count.index)

  # Data Center of this subnet.
  availability_zone = element(var.az_public, count.index)

  # Enabling automatic public IP assignment on instance launch!
  map_public_ip_on_launch = true

  tags = {
    Name = "${element(var.az_public, count.index)} - Public Subnet"
  }
}