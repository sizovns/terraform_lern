#!/bin/bash
yum -y update
yum -y install httpd

lesson="Lesson 6"
echo "<h2>My Simple Apache Web Server<h2><br>Builded with Terraform using External Script $lesson!" >/var/www/html/index.html

cat <<EOF >/var/www/html/index.html
<html>
<h2>Build with Terraform <font color="red"> v1.8.5</font></h2><br>
<p>Owner ${f_name} ${l_name}</p><br>

Nice TV Shows: 
%{ for show in names ~}
<p>${show}</p>, 
%{ endfor ~}
</html>
EOF

sudo service httpd start
chkconfig httpd on
