resource "aws_subnet" "rds" {
  count = length(var.subnet_rds)
  depends_on = [
    aws_vpc.custom
  ]
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = element(var.subnet_rds, count.index)
  availability_zone       = element(var.az_rds, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${element(var.az_rds, count.index)} - RDS Subnet"
  }
}