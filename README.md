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

## lesson-10

Data Source [AMI](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) search and create server based on latest ami.

## lesson-11

High availability web server + green/blue deployment in default VPC

- Auto Scaling Group using 2 Availability Zones
- Classic Load Balancer in 2 Availability Zones

## lesson-12

High availability web server + green/blue deployment in default VPC

- Default Tags
- Auto Scaling Group using 2 Availability Zones
- Launch Template

New way to organize availability

## lesson-13

Using variables

- without default
- default
- description
- types
- merge tags

Using tfvars

- Using `terraform <command> -var="variable_name=variable_value"`
- Using env variables `export TF_VAR_variable_name=variable_value`
- Using `terraform.tfvars` - replaced variables to specified in file
- Using `*.auto.tfvars` for several envs, to specify what var file to use: `terraform plan -var-file="dev.auto.tfvars"`

## lesson-14

Local vars

- Using local vars to create var from several vars.
- Using join to create string with delimiter from a list
