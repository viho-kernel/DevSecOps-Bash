#!/bin/bash

systemctl status nginx >> /dev/null
if [ $? -eq 0 ]; then
    echo "The previous command executed successfully. Nginx is running."
else
    echo "The previous command failed. Nginx is not running."

fi