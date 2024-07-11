output "web_loadbalancer_url" {
  value = aws_lb.web_lb.dns_name
}
