resource "aws_security_group" "bastion_sg" {
  name        = "bastion-security-group"
  vpc_id      = aws_vpc.custom.id
  description = "Allow SSH to bastion and outbound internet"
  tags = {
    Name = "Bastion SG"
  }
}

resource "aws_security_group_rule" "ssh" {
  description       = "Terraform-managed SSH access"
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "internet" {
  description       = "managed bastion egress internet"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "intranet" {
  description       = "managed bastion egress intranet"
  count             = length(var.subnet_cidrs_public) > 0 ? 1 : 0
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.subnet_cidrs_public
  security_group_id = aws_security_group.bastion_sg.id
}


resource "aws_instance" "bastion" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.private,
    aws_subnet.public,
    aws_security_group.web_sg,
    aws_security_group.bastion_sg
  ]

  ami           = var.ami
  key_name      = "bastion"
  instance_type = var.instance_type
  # Public Subnet ID
  #count     = length(var.subnet_cidrs_public)
  subnet_id = element(aws_subnet.public.*.id, 0)


  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  # Installing required softwares into the system!
  #ssh-keygen -t ed25519 and /home/denis/.ssh/webserver
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/bastion")
    host        = aws_instance.bastion.public_ip
  }

  tags = {
    Name    = "Bastion"
    Progect = "Task_5.1"
  }
}
resource "aws_key_pair" "bastion_auth" {
  key_name   = "bastion"
  public_key = file("~/.ssh/bastion.pub")

}
