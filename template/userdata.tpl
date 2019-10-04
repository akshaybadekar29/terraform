#! /usr/bin/bash
echo "hello world"
yum update -y
yum install -y httpd
sudo systemctl start httpd
     