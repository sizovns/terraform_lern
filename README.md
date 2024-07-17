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

## lesson-15

Using local-exec (run local commands)

- Using resource `null_resource`

## lesson-16

Using SSM Parameter Strore for storing passwords

- How to store and get passwords from SSM
- How to change passwords (using `keepers` and some variable)
- How to use passwords on RDS

## lesson-17

Using Lookups and Conditions

- if condition (:? elvis `intance_type = var.env == "prod" ? "t2.large" : "t2.micro"`)
- Lookup (how to get from map - `intance_type = lookup(var.ec2_size, "prod")` from where we get and key to get)

## lesson-18

Using cycles count and for it

- Using `count` with length of list
- Using `element(list, index)`
- Using index of count `count.index`
- Get only 1 field form list of objects (use `[*]` and field name `id` on resource eg `aws_iam_users.users[*].id`)
- Using for i in list to output several values from iterated object
- Using for i in list to output in map (when create map we use key => value)
- Using for i with if condition
- For dinamic use `for_each`

## lesson-19

Create resources (deployments) to several regions or accounts

- Use alias in provider section with provider in resource section
- Use other account with role block `assume_role` in `provider`, or if use other creds `access_key`, `secret_key` in `provider`

## lesson-20

Terraform remote state

- Create a bucket for tfstate storage (important add versioning)
- Using `terraform` block to use tfstate from s3 bucket
- To get data from other remote state need to set output and get by `data "terraform_remote_state"`

## lesson-21

Terraform modules

- Modules in terraform it like functions in programmin lang.
- Module should be located in other directory or in other git repo
- To create module need to delete `provider` section and move it to separate directory
- To use module we created directory `project-1`
- To use module needs to use block with `module` and paramter `source`
- [Source](https://developer.hashicorp.com/terraform/language/modules/sources) could be local or some remote repo/registry
- I use my own github [repo](https://github.com/sizovns/terraform_lern_modules) for modules (`aws_network`)

## lesson-22

Create terraform module which will be in use on several AWS Regions or Accounts

- To use several providers in module needs to use section `terraform` with `require_providers` section (`module/servers/main.tf`)

## lesson-23

Example of deploy several infrastructures for envs (eg Dev, Staging, Prod)

- Mostly here we will have something like structure without real terraform code
- Do not forgot using remote state and separate to files `variables` and `outputs`
- Do not forgot naming of remote state, where your code - same with remote state dir -
  eg for dev app1 (`dev/vpc/applications/app1/terraform.tfstate`)

## lesson-24

Global variables

- Save global vars to remote state
- To use global vars needs to get data from other remote state `data "terraform_remote_state"`
- To use global vars recommended use `locals` to avoid big names


## lesson-25

Work with GCP
- Create an account
- Mange key
- Create a instance


## Usefull links 

How to lern more

- Lern from terraform - https://developer.hashicorp.com/terraform/tutorials
- Blog - https://blog.gruntwork.io/terraform-up-running-5869b53edcde
- Terrafrom modules repo - https://github.com/terraform-aws-modules
-  