#!/bin/bash

sudo apt update
sudo apt install -y nginx
echo "This is the templatefile method ${aws_region}." > /var/www/html/index.html

sudo systemctl enable --now nginx