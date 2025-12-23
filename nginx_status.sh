#!/bin/bash

cowsay "This is an example"

systemctl status nginx

if [ $? -eq 0 ]; then
    echo "The previous command executed successfully. Nginx is running."
else
    echo "The previous command failed. Nginx is not running."

cowsay "Please check the nginx service."
cowsay "Exiting the script now."
cowsay "Ambeee"
fi