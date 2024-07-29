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

## lesson-26

Work with manualy created resources:

1. Some created resource in cloud
2. In `main.tf` need to use empty resource (eg `resource "aws_instance" "my" {}`)
3. init and import (`terraform import aws_instance.my i-0641f8d266e193134`)
4. Fix some problems which will gave you terraform (plan/apply) from tfstate or command output

Example:

```
terraform import aws_instance.my_imported_instance i-0d86663bf6d6c4709
aws_instance.my_imported_instance: Importing from ID "i-0d86663bf6d6c4709"...
aws_instance.my_imported_instance: Import prepared!
  Prepared aws_instance for import
aws_instance.my_imported_instance: Refreshing state... [id=i-0d86663bf6d6c4709]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

## lesson-27

Semi-automatic resource import (v1.5 and later)

1. Need to declare block `import {}` with id from and to resource
2. To import need run command `terraform plan -generate-config-out=generated-sg.tf`
3. Now all resources in generated file, we can apply to import it and change what we need to

## lesson-28

How to recreate resource

1. You can recreate resource by comment this resource than apply and uncomment and apply again
2. You can recreate resource by using `count=0`
3. You can use `terraform taint` - `terraform taint aws_instance.node2` and after apply
4. You can use `terraform apply -replace aws_instance.node2` it will recreate resource

## lesson-29

Working with Remote State and Refactoring code (cli `terraform state`)

1. `terraform state show` - show state of specific resource (get data only)
2. `terraform state list` - show all resources which fixed in remote state (get data only)
3. `terraform state pull` - read full remote state and print out (you can save state to file) (get data only)
4. `tarraform state rm resource_name` - removed state of some resource (change data)
5. `terraform state mv resource_name_old resource_name_new` - changed name of resource (change data)
6. `terraform state push` - overwrite remote state

We have old-all and we want to separate it to staging and prod dirs and remote state

!IMPORTANT do not use default VPC or you need to move it to both envs (hard way :D )

1. Create new dirs (new-prod and new-stag)
2. Copy files to specific envs and fix some variables (like where we will storage remote state, etc)
3. Move state `terraform state mv -state-out="terraform.tfstate" aws_eip.prod-ip1 aws_eip.prod-ip1` (eg for aws_eip.prod_ip1), to add to this local terrafrom tfstate file data you can run this command again with other parameters as resources
4. After move `terraform.tfstate` to `new-prod` directory and init terraform, and you will see that terraform give to you possibility to import existing local tfstate to new backend (s3).
5. Terraform apply(plan) to check that 0 changes
6. Same for new-stag
7. Delete other resources from old-all
8. Done, now you can manage by terraform both you envs separatly

If you forgot something to move:

1. Pull tfstate from some of envs (eg prod)
2. Move from old to new tfstate which you created by pull
3. Now you can push this local tfstate to remote s3
4. terraform apply

## lesson-30

Work with terraform workspace:

1. `terraform workspace show` - by default you use default workspace
2. `terraform workspace list` - show all workspaces
3. `terraform workspace new` - create new workspace and switch to it
4. `terraform workspace select` - switch to another workspace
5. `terraform workaspace delete` - delete workspace

As example we firstry apply our configuration, then created new workspace, and now we can apply our configuration again, because we an another workspace.

When we created a new workspace we will see in s3 bucket new bucket directory `env:/workspace_name/dir_to_tfstatefile`

Some of resources will conflict by name thats why we should use special variable in it - `${terraform.workspace}`

## lesson-31

Custom provider (eg domino pizza)

1. To use custom provider needs to download it to your local machine or register it to the hashicorp
2. Give `+x` permissions to this custom provider file
3. Create directory for this custom provider `~/.terraform.d/plugins/dominos.com/myorg/dominos/1.0/linux_amd64/`
4. Move provider to custom provider dir
5. Add terraform required providers with source and version

## lesson-32

Use loops inside looops for difficult tasks

## Useful links

How to lern more

- Lern from terraform - https://developer.hashicorp.com/terraform/tutorials
- Blog - https://blog.gruntwork.io/terraform-up-running-5869b53edcde
- Terrafrom modules repo - https://github.com/terraform-aws-modules
