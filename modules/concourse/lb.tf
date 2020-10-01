resource "aws_elb" "web-elb" {
  name = "${var.prefix}-elb"
  subnets = [aws_subnet.conc_subnet.id]
  security_groups = [aws_security_group.access_concourse.id]
#   # The same availability zone as our instances
#   availability_zones = local.availability_zones

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#TODO listener für ssh? ssl?

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}