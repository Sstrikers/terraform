#!/bin/bash
yum -y update
yum -y install httpd
echo "This is: $HOSTNAME" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
