# security groups?
# network interfaces

data "template_file" "web_initialization" {
  template = file("${path.module}/templates/web_user_data.sh")

  vars = {
    instance_type = "Concourse Web ${var.prefix}"
  }
}

resource "aws_autoscaling_group" "web-asg" {
  name                 = "${var.prefix}-terraform-example-asg-web"
  max_size             = var.web.max
  min_size             = var.web.min
  desired_capacity     = var.web.desired
  load_balancers       = [aws_elb.web-elb.name]
  health_check_type = "ELB"


  launch_template {
    id = aws_launch_template.web.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Concourse Web ${var.instances_prefix}_${aws_launch_template.web.id}_${aws_launch_template.web.latest_version}"
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "web" {
  name          = "${var.prefix}-terraform-example-lc-web"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.web.instance_type
  key_name      = aws_key_pair.katharina.key_name
  # key_name      = katharinas_key

  user_data = base64encode(data.template_file.web_initialization.rendered)

  network_interfaces {
    subnet_id = aws_subnet.conc_subnet.id
    security_groups = [aws_security_group.access_concourse.id]
    associate_public_ip_address = true
    # network_interface_id = aws_network_interface.internet.id
  }
}

data "template_file" "worker_initialization" {
  template = file("${path.module}/templates/worker_user_data.sh")

  vars = {
    instance_type = "Concourse Worker ${var.prefix}"
  }
}

resource "aws_autoscaling_group" "worker-asg" {
  name                 = "${var.prefix}-terraform-example-asg-worker"
  max_size             = var.worker.max
  min_size             = var.worker.min
  desired_capacity     = var.worker.desired
  # load_balancers       = [aws_elb.web-elb.name] TODO eigener lb?
  health_check_type = "ELB"

  
  launch_template {
    id = aws_launch_template.worker.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Concourse Worker ${var.instances_prefix}_${aws_launch_template.worker.id}_${aws_launch_template.worker.latest_version}"
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "worker" {
  name          = "${var.prefix}-terraform-example-lc-worker"
  image_id      = data.aws_ami.ubuntu.id 
  instance_type = var.worker.instance_type
  key_name      = aws_key_pair.katharina.key_name

  user_data = base64encode(data.template_file.worker_initialization.rendered)

  network_interfaces {
    subnet_id = aws_subnet.conc_subnet.id
    security_groups = [aws_security_group.access_concourse.id]
    associate_public_ip_address = true
    # network_interface_id = aws_network_interface.internet.id
  }
}