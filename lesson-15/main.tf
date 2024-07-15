provider "aws" {
  region = "eu-north-1"
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
  depends_on = [null_resource.command1]
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command     = "print('Hello from Python!')"
    interpreter = ["python", "-c"]
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
    environment = {
      "NAME1" = "Name first"
      "NAME2" = "Name second"
      "NAME3" = "Name third"
    }
  }
}

resource "aws_instance" "myserver" {
  ami           = "ami-052387465d846f3fc"
  instance_type = "t3.micro"
  provisioner "local-exec" {
    command = "echo 'Hello from AWS instance'"

  }
}

resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo Terraform END: $(date) >> log.txt"
  }
  depends_on = [null_resource.command1, null_resource.command2, null_resource.command3, null_resource.command4, aws_instance.myserver]
}
