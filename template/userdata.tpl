#! /usr/bin/bash
echo "hello world"
echo "###############################"
echo "#############httpd#############"
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
     