#!/bin/bash
yum -y update
yum -y install httpd
lesson="Lesson 3"
echo "<h2>My Simple Apache Web Server<h2><br>Builded with Terraform using External Script $lesson!" >/var/www/html/index.html
sudo service httpd start
chkconfig httpd on
