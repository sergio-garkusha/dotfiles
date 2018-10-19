#!/bin/bash -e

if [ "$1" == "" ]; then
  echo "CLI util for creation of the Apache virtual hosts"
  exit 100
fi

# Define current user name
userName="$(logname)"

# Add .loc prefix to your project name
dirName=$1

# Define abspath to project dir
absolutePath="/Users/$userName/Dev/http/php/$dirName"

# Check if project already exists in httpd-vhosts.conf
if grep -q $dirName '/Applications/MAMP/conf/apache/extra/httpd-vhosts.conf'; then
  echo "NOTICE: This virtual host is already created."
  echo "Exiting: All OK"
  exit 100
fi

echo "Creating virtual host:"
echo ""

# Create virtual host
echo "" >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '%s\n' '<VirtualHost *:80>' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '\t%s\n' 'ServerAdmin admin@'$userName'' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '\t%s\n' 'DocumentRoot "'$absolutePath'"' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '\t%s\n' 'ServerName '$dirName'' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '\t%s\n' 'ServerAlias www.'$dirName'' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '\t%s\n' 'ErrorLog "logs/'$dirName'-error_log"' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '\t%s\n' 'CustomLog "logs/'$dirName'-access_log" common' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
printf '%s\n' '</VirtualHost>' >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf

echo "Virtual host '$dirName' was created"
echo "for the '$absolutePath' directory."
echo ""
# Let's add our new host to /etc/hosts now
echo "Adding record to the /etc/hosts:"
echo ""

# Check if project name is already exists in /etc/hosts
if grep -q $dirName '/etc/hosts'; then
  echo "NOTICE: The hostname of the project is already added to /etc/hosts."
else
  printf '%s\n' '127.0.0.1   '$dirName'     www.'$dirName'' >> /etc/hosts
  printf '%s\n' '127.0.0.1   '$dirName'     www.'$dirName''
fi

echo "Exiting: All OK"
