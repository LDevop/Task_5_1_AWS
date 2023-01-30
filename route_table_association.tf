# Creating a resource for the Route Table Association!
resource "aws_route_table_association" "RT-IG-Association" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.public,
    aws_subnet.private,
    aws_route_table.Public-Subnet-RT
  ]

  # Public Subnet ID
  count     = length(var.subnet_cidrs_public)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  #  Route Table ID
  route_table_id = aws_route_table.Public-Subnet-RT.id
}