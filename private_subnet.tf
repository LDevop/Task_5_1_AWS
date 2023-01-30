# Creating Public subnet!
resource "aws_subnet" "private" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.public
  ]

  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id

  # IP Range of this subnet
  cidr_block = var.subnet_cidr_private

  # Data Center of this subnet.
  availability_zone       = var.az_private
  map_public_ip_on_launch = false
  tags = {
    Name = "${(var.az_private)} - Private Subnet"
  }
}