provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 12"
    }
  }
}

#-----------------------------------------------------------------

resource "aws_security_group" "web_sg" {
  name   = "Dinamic Security Group"
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name = "SG for WebServer"
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

#-----------------------------------------------------------------

resource "aws_launch_template" "web_lt" {
  name                   = "WebServer-Highly-Available-LT"
  image_id               = data.aws_ami.latest_aws_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = filebase64("${path.module}/user_data.sh")
}

resource "aws_lb" "web_lb" {
  name               = "WebServer-Highly-Available-ALB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_default_subnet.default_az_1.id, aws_default_subnet.default_az_2.id]
}

resource "aws_lb_target_group" "web_lb_tg" {
  name                 = "WebServer-Highly-Available-TG"
  vpc_id               = aws_default_vpc.default.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10 # seconds
}

resource "aws_lb_listener" "web_lb_listener_http" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
  }
}

#-----------------------------------------------------------------

resource "aws_autoscaling_group" "web_ag" {
  name                = "WebServer-Highly-Available-ASG-Ver-${aws_launch_template.web_lt.latest_version}"
  min_size            = 2
  max_size            = 2
  min_elb_capacity    = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_default_subnet.default_az_1.id, aws_default_subnet.default_az_2.id]
  target_group_arns   = [aws_lb_target_group.web_lb_tg.arn]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = aws_launch_template.web_lt.latest_version
  }

  dynamic "tag" {
    for_each = {
      Name = "WebServer in ASG-v${aws_launch_template.web_lt.latest_version}"
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
#-----------------------------------------------------------------
