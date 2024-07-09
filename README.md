# [AWS Terraform lessons](https://www.udemy.com/course/rus-terraform/)

## lesson-1

Create ec2 instances and hide secrets for aws

- plan
- apply
- count of servers
- apply (update)
- destroy

## lesson-2

- Create our own web server with security groups

## lesson-3

- Work with user data as file

## lesson-4

- User data as template
- Use console for testing (terraform console)

## lesson-5

- Dynamic code blocks for ingress rules

## lesson-6

Lyfe Cycle resources and ~ Zero DownTime:

- `prevent_destroy = true` - prevent destroy resource eg DB
- `ignore_changes = [ami, user_data]` - prevent changes if chanded some paramters eg ami, user_data etc
- EIP and creating new server before terminating old one (`create_before_destroy = true`)

## lesson-7 

Outputs:
- server id
- ip address
- Outputs to separate file
- Outputs need to future remote state
- `terraform show` to see what you can print as output

Just move from `web_server.tf` to `main.tf` to terraform code style


## lesson-8

Work with server dependencies
- depends_on used as array for dependency servers from each other

## lesson-9

[Data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance) and [Meta Data Sources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)

Learn on creation subnets