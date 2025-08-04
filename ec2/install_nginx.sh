#!/bin/bash

sudo apt update
sudo apt install -y nginx
echo "This is a file module method" > /var/www/html/index.html

sudo systemctl enable --now nginx