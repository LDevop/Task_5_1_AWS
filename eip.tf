# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.RT-IG-Association,
    aws_internet_gateway.Internet_Gateway
  ]
  vpc              = true
  public_ipv4_pool = "amazon"
  tags = {
    Name = "ElasticIP"
  }
}