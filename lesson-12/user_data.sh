#!/bin/bash

yum -y update
yum -y install httpd

lesson="Lesson 12"
myip=`hostname -i`

cat <<EOF >/var/www/html/index.html
<html>
<body bgcolor="grey">
<h2>Build with Terraform <font color="red"> v1.8.5</font></h2><br>
<p>Lesson-$lesson</p><br>
<p>My IP: $myip</p><br>

<font color="magenta">
<b>Version 2.0</b>
</body>
</html>
EOF

sudo service httpd start
chkconfig httpd on
