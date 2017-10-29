#!/bin/bash -e

# ALGORITHM:
# - Opens MAMP.app
# - Creates virtual host for project
# - Adds project host to hosts file
# - Creates wp-config.php with DB data, debug and with permissions fix
# - Creates DB
# - Restarts MAMP
# - Opens new Chrome instance in incognito mode

# Check if it is root
if [[ $EUID -ne 0 ]]; then
  echo "You must be root to do this." 1>&2
  exit 100
fi

# Run/Reboot MAMP's MySQL
open /Applications/MAMP/MAMP.app

###############################################################################

# Define name & abspath of the project

if [ "$1" != "" ]; then
  dirName=$1
else
  echo "Please enter the name of a project"
  read -pr "where your WP files will be placed: " dirName
  echo ""
fi

if [[ -z "$dirName" ]]; then
  echo "ERROR: Project name is required."
  echo "Execution aborted."
  echo ""
  exit 100
fi

echo "Enter MySQL db name:"
read -r dbName
echo "Enter MySQL username:"
read -r dbUname
echo "Enter MySQL password:"
stty_orig=$(stty -g) # save original terminal settings.
stty -echo          # turn-off echoing.
read -r dbPass         # read the password.
stty "$stty_orig"     # put back the original settings.
# read dbPass

if [[ -z "$dbName" ]]; then
  echo "ERROR: MySQL db name is required."
  echo "Execution aborted."
  echo ""
  exit 100
fi

if [[ -z "$dbUname" ]]; then
   echo "ERROR: MySQL username is required."
   echo "Execution aborted."
   echo ""
   exit 100
fi

if [[ -z "$dbPass" ]]; then
  echo "ERROR: MySQL password is required."
  echo "Execution aborted."
  echo ""
  exit 100
fi

# Define current user name
userName="$(logname)"

# Add .loc prefix to your project name
dirName="$dirName.loc"

# Define abspath to project dir
absolutePath="/Users/$userName/Dev/http/php/$dirName"


# Check if project already exists in httpd-vhosts.conf
if grep -q "$dirName" '/Applications/MAMP/conf/apache/extra/httpd-vhosts.conf'; then
  echo "ERROR: This virtual host is already created."
  echo "Please use another name of the project."
  echo "Execution aborted."
  echo ""
  exit 100
fi

# Check if project folder is already exists in ~/Dev/http/php
if ls ~/Dev/http/php | grep "$dirName"; then
  echo "ERROR: A folder with this project name is already created."
  echo "Perhaps you have something important there, please check."
  echo "Please use another name of the project."
  echo "Execution aborted."
  echo ""
  exit 100
fi


# If all OK, let's build our project invironment
echo "WordPress will be installed by the script."
echo ""


mkdir -p ~/Dev/http/php/"$dirName"
cd ~/Dev/http/php/"$dirName"
wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
mv wordpress/* .
rm latest.tar.gz && rm -rf wordpress


echo "WordPress is installed."
echo "Now it's time to make virtual host for it."
echo ""


# Create virtual host
{ echo "" } >> /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf
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
echo "Let's add our new host to '/etc/hosts' now'."
echo ""

# Check if project name is already exists in /etc/hosts
if grep -q $dirName '/etc/hosts'; then
  echo "NOTICE: The hostname of the project is already added to /etc/hosts."
  echo ""
else
  printf '%s\n' '127.0.0.1   '$dirName'     www.'$dirName'' >> /etc/hosts
  printf '%s\n' '127.0.0.1   '$dirName'     www.'$dirName''
  echo ""
fi


echo "All OK, move on."
echo ""


# Let's generate a wp-config.php
echo "Let's create a 'wp-config.php' file"

mkdir -p config
cp wp-config-sample.php config/wordpress.php

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/wordpress.php)
awk -v n=$wpcfgDBN -v s="define('DB_NAME', '$dbName');" 'NR == n {print s} {print}' config/wordpress.php > config/awk.php
wpcfgDBN=$(($wpcfgDBN + 1))
sed -i "" "${wpcfgDBN}d" config/awk.php

wpcfgDBU=$(awk '/DB_USER/{ print NR; exit }' config/awk.php)
awk -v n=$wpcfgDBU -v s="define('DB_USER', '$dbUname');" 'NR == n {print s} {print}' config/awk.php > config/awk1.php
wpcfgDBU=$(($wpcfgDBU + 1))
sed -i "" "${wpcfgDBU}d" config/awk1.php

wpcfgDBP=$(awk '/DB_PASSWORD/{ print NR; exit }' config/awk1.php)
awk -v n=$wpcfgDBP -v s="define('DB_PASSWORD', '$dbPass');" 'NR == n {print s} {print}' config/awk1.php > config/awk2.php
wpcfgDBP=$(($wpcfgDBP + 1))
sed -i "" "${wpcfgDBP}d" config/awk2.php

wpcfgDEBUG=$(awk '/WP_DEBUG/{ print NR; exit }' config/awk2.php)
awk -v n=$wpcfgDEBUG -v s="" 'NR == n {print s} {print}' config/awk2.php > config/awk3.php
wpcfgDEBUG=$(($wpcfgDEBUG + 1))
sed -i "" "${wpcfgDEBUG}d" config/awk3.php

wpcfgDEBUG=$(awk '/WP_DEBUG/{ print NR; exit }' config/awk3.php)
awk -v n=$wpcfgDEBUG -v s="define('WP_DEBUG', true);" 'NR == n {print s} {print}' config/awk3.php > config/awk4.php
wpcfgDEBUG=$(($wpcfgDEBUG + 1))
sed -i "" "${wpcfgDEBUG}d" config/awk4.php

rm config/wordpress.php
mv config/awk4.php wp-config.php

printf '%s\n' ''
printf '%s\n' 'if (is_admin()) {' >> wp-config.php
printf '\t%s\n' 'add_filter("filesystem_method", create_function('"'"'$a'"'"', "return \"direct\";" ));' >> wp-config.php
printf '\t%s\n' 'define( "FS_CHMOD_DIR", 0751 );' >> wp-config.php
printf '%s\n' '}' >> wp-config.php
printf '%s\n' ''

find . -type f -name awk\* -exec rm {} \;
rm -rf config

# Config was created
echo "Config file was created "
echo ""


# Let's start to deal with the DB
echo "Let's finally deal with DB"
echo ""

read -p "Are your MAMP's MySQL running now? [Y/n]: " mySQL
echo ""


if [ -z "$mySQL" ] || [ "$mySQL" == "y" ] || [ "$mySQL" == "Y" ]; then
  /Applications/MAMP/Library/bin/mysql -h localhost -u$dbUname -p$dbPass -e "CREATE DATABASE $dbName"
  echo "DataBase '$dbName' was created for '$dbUname' user."
  echo ""
else
  echo "DataBase '$dbName' wasn\'t created for '$dbUname' user."
  echo "You should create it manually."
  echo ""
fi


# Let's set a right permissions for everithing
echo "Setting permissions & ownership."
echo ""
chown -R $userName:_www "$absolutePath"
chmod -R 775 "$absolutePath/wp-content"


# Run/Reboot MAMP's apache
osascript -e 'quit app "MAMP"'  # it is general way of how to close GUI app
open /Applications/MAMP/MAMP.app


# Start browser
echo "Starting new Chrome in incognito."
echo ""
/usr/bin/open -a "/Applications/Google Chrome.app" --new --args -incognito "http://$dirName"


# All done!
echo "All done, have fun!"
echo ""
