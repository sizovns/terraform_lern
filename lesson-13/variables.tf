variable "region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS region to deploy Server"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type of Server"
}


variable "allow_ports" {
  type        = list(string)
  default     = ["80", "443"]
  description = "List of ports to open for Server"
}

variable "detailed_monitoring" {
  type    = bool
  default = false
}

variable "common_tags" {
  type = map(string)
  default = {
    Owner       = "Nikita S"
    CreatedBy   = "Terraform"
    Project     = "Lesson 13"
    Environment = "development"
  }
  description = "Common tags to apply to all resources"

}
