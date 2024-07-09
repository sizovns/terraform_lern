output "webserver_instance_id" {
  value = aws_instance.WebServer.id
}

output "webserver_public_ip" {
  value = aws_eip.webserver_static_ip.public_ip
}

output "webserver_public_dns" {
  value = aws_eip.webserver_static_ip.private_dns
}

output "webserver_security_group_id" {
  value       = aws_security_group.webserver.id
  description = "This is security group ID" # Just for you like a comment
}


output "webserver_security_group_arn" {
  value = aws_security_group.webserver.arn
}

