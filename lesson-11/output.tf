output "web_loadbalancer_url" {
  value = aws_elb.web_elb.dns_name
}
