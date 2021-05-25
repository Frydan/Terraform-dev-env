#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo chkconfig httpd on
sudo echo "This instance id: " > /var/www/html/index.html
sudo curl http://169.254.169.254/latest/meta-data/instance-id >> /var/www/html/index.html
sudo systemctl start httpd