provider "aws" {
  region = "eu-north-1"
}

import {
  id = "sg-09dad35d364f95053"
  to = aws_security_group.sql
}

import {
  id = "i-0c31550f7153c2c53"
  to = aws_instance.sql_server 
}

import {
  id = "i-0f4b9df3a831b1316"
  to = aws_instance.web_server 
}

