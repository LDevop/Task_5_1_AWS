# Creating an Internet Gateway for the VPC
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.private,
    aws_subnet.public
  ]

  # VPC in which it has to be created!
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "Internet-Gateway"
  }
}