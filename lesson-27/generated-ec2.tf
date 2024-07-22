# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "web_server" {
  ami                                  = "ami-0249211c9916306f8"
  associate_public_ip_address          = true
  availability_zone                    = "eu-north-1b"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  monitoring                           = false
  placement_partition_number           = 0
  private_ip                           = "172.31.37.237"
  secondary_private_ips                = []
  security_groups                      = ["SQL_SG"]
  source_dest_check                    = true
  subnet_id                            = "subnet-0d804a6b692c0b316"
  tags = {
    Name = "WEBServer"
  }
  tags_all = {
    Name = "WEBServer"
  }
  tenancy                     = "default"
  vpc_security_group_ids      = ["sg-09dad35d364f95053"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 8
    volume_type           = "gp3"
  }
}

# __generated__ by Terraform
resource "aws_instance" "sql_server" {
  ami                                  = "ami-0249211c9916306f8"
  associate_public_ip_address          = true
  availability_zone                    = "eu-north-1b"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  monitoring                           = false
  placement_partition_number           = 0
  private_ip                           = "172.31.36.212"
  secondary_private_ips                = []
  security_groups                      = ["SQL_SG"]
  source_dest_check                    = true
  subnet_id                            = "subnet-0d804a6b692c0b316"
  tags = {
    Name = "SQL_Server"
  }
  tags_all = {
    Name = "SQL_Server"
  }
  tenancy                     = "default"
  vpc_security_group_ids      = ["sg-09dad35d364f95053"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 8
    volume_type           = "gp3"
  }
}
