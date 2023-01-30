# Creating a Security Group for WordPress
resource "aws_security_group" "web_sg" {
  # Name of the security Group!
  name        = "web-security-group"
  description = "HTTP, HTTPS, SSH, DB"

  depends_on = [
    aws_vpc.custom,
    aws_subnet.public,
    aws_subnet.private,
    aws_subnet.rds
  ]
  # VPC ID in which Security group has to be created!
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for webserver access!
  ingress {
    description = "HTTP for web"
    from_port   = 80
    to_port     = 80

    # Here adding tcp instead of http, because http in part of tcp only!
    protocol    = "tcp"         #"tcp"
    cidr_blocks = ["0.0.0.0/0"] #change to var.ssh_location
  }

  ingress {
    description = "database connect"
    from_port   = 5432
    to_port     = 5433
    protocol    = "tcp"
    cidr_blocks = var.subnet_cidrs_public
  }
  ingress {
    description = "redis cluster"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.subnet_cidrs
  }
  ingress {
    description = "memcache cluster"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = var.subnet_cidrs
  }

  # ingress {
  #   description = "HTTPS for web"
  #   from_port   = 443
  #   to_port     = 443

  #   # Here adding tcp instead of http, because http in part of tcp only!
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"] #change to var.ssh_location
  # }

  # Created an inbound rule for SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22

    # Here adding tcp instead of ssh, because ssh in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #change to var.ssh_location
  }

  # Outward Network Traffic for the WordPress
  egress {
    description = "output from webserver"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


