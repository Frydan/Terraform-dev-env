#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo yum install ruby -y
sudo yum install aws-cli -y
cd /home/ec2-user
wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
sudo chmod +x ./install
./install auto
sudo chkconfig httpd on
sudo echo "This instance id: " > /var/www/html/index.html
sudo curl http://169.254.169.254/latest/meta-data/instance-id >> /var/www/html/index.html
sudo echo "<br><br>Webserver Version 1.0v" >> /var/www/html/index.html
sudo systemctl start httpd