resource "aws_elb" "elb_www" {
  name    = "www-elb"
  subnets = aws_subnet.public.*.id
  #availability_zones = var.az_public
  security_groups = [aws_security_group.web_sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  #   listener {
  #     instance_port     = 443
  #     instance_protocol = "http"
  #     lb_port           = 443
  #     lb_protocol       = "https"
  #   }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = [aws_instance.webserver_2.id, aws_instance.webserver_1.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "www-elb"
  }
}

output "elb-dns-name" {
  value = aws_elb.elb_www.dns_name
}