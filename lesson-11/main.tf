provider "aws" {
  region = "eu-north-1"
}


resource "aws_security_group" "web_sg" {
  name   = "Dinamic Security Group"
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name    = "SG for WebServer"
    Owner   = "Nikita"
    Project = "Terraform Lesson 11"
  }

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "web_lc" {
  #   name            = "WebServer-HighlyAvaliable-LC"
  name_prefix     = "WebServer-HighlyAvaliable-LC-"
  image_id        = data.aws_ami.latest_aws_linux.id
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.web_sg.id]
  user_data       = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web_elb" {
  name               = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.availablity_zones.names[0], data.aws_availability_zones.availablity_zones.names[1]]
  security_groups    = [aws_security_group.web_sg.id]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 10
    target              = "HTTP:80/"
  }

  tags = {
    name = "Web Server - Highly Avaliable - ELB"
  }

}

resource "aws_autoscaling_group" "web_ag" {
  name                 = "ASG-${aws_launch_configuration.web_lc.name}"
  launch_configuration = aws_launch_configuration.web_lc.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  vpc_zone_identifier  = [aws_default_subnet.default_az_1.id, aws_default_subnet.default_az_2.id]
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.web_elb.name]

  dynamic "tag" {
    for_each = {
      Name   = "WebServer-in-ASG"
      Owner  = "Nikita S"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
