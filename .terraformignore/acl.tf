# create VPC Network access control list   

resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.custom.id
  ingress {
    protocol   = "-1" #"tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  #  ingress {
  #     protocol   = "tcp"
  #     rule_no    = 101
  #     action     = "allow"
  #     cidr_block = "0.0.0.0/0"
  #     from_port  = 22
  #     to_port    =22
  #   }
  # ingress {
  #   protocol   = "tcp"
  #   rule_no    = 102
  #   action     = "allow"
  #   cidr_block = "0.0.0.0/0"
  #   from_port  = 443
  #   to_port    = 443
  # }
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "acl webserver"
  }
}

resource "aws_network_acl_association" "acl_public" {
  network_acl_id = aws_network_acl.acl.id
  count          = length(var.subnet_cidrs_public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

# resource "aws_network_acl_association" "acl_private" {
#   network_acl_id = aws_network_acl.acl.id
#   subnet_id      = aws_subnet.private.id
# }
