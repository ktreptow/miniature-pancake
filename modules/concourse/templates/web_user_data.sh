#!/bin/sh
touch ichwarhier
echo "Hello, ${instance_type}" > index.html
nohup busybox httpd -f -p 80 &