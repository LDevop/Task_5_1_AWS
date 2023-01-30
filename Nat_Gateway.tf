# Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP,
    aws_internet_gateway.Internet_Gateway
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id

  # Associating it in the Public Subnet!
  # count     = length(var.subnet_cidrs_public)
  # subnet_id = element(aws_subnet.public.*.id, 0)
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "Nat-Gateway"
  }
}
