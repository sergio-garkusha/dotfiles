#!/bin/bash -e

# This is the old basic code
# It was an initial idea

# wget http://wordpress.org/latest.tar.gz
# tar xfz latest.tar.gz
# mv wordpress/* .
# rm latest.tar.gz && rm -rf wordpress

# TODO:
# - Create DB
# - Create virtual hosts
# - Edit hosts file
# - Open wp-config.php in vim for setup


# Check if it is root
if [[ $EUID -ne 0 ]]; then
   echo "You must be root to do this." 1>&2
   exit 1
fi

###############################################################################

# Define name & abspath of the project
absolutePath=$(pwd)
dirName=${PWD##*/}


# Check if project exists in httpd-vhosts.conf
if grep -q "$dirName" '/opt/lampp/etc/extra/httpd-vhosts.conf'; then
    echo "================================================================="
    echo "ERROR: This virtual host is already created."
    echo "Please use another name of the project folder."
    echo "================================================================="
    exit 1
fi


# If all OK, let's build our project invironment
echo "================================================================="
echo "You are a lazy one, so WordPress will be installed by the script."
echo "================================================================="
echo ""

# Init git repository
echo "================================================================="
echo "Starting to init a git repo here."
echo "================================================================="
echo ""

git init

# Add latest WordPress as a submodule
echo "Please enter the name of a directory"
read -pr "where your WP files will be placed[wp]:" submoduleDir
submoduleDir=${submoduleDir:-wp}

echo "================================================================="
echo "Adding latest WordPress as a submodule."
echo "================================================================="
echo ""

if [ -d "$absolutePath/$submoduleDir" ]
then
    echo "Directory /path/to/dir exists."
else
    git submodule add git://github.com/WordPress/WordPress.git "$submoduleDir"/
fi


echo "================================================================="
echo "WordPress is installed. I'm thrilled :) "
echo "Now it's time to make a virtual host for it."
echo "================================================================="
echo ""


# Create virtual host
{ echo "" } >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '%s\n' '<VirtualHost *:80>' >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '\t%s\n' 'ServerAdmin admin@'$SUDO_USER'' >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '\t%s\n' 'DocumentRoot "'$absolutePath'"' >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '\t%s\n' 'ServerName '$dirName'' >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '\t%s\n' 'ServerAlias www.'$dirName'' >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '\t%s\n' 'ErrorLog "logs/'$dirName'-error_log"' >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '\t%s\n' 'CustomLog "logs/'$dirName'-access_log" common' >> /opt/lampp/etc/extra/httpd-vhosts.conf
printf '%s\n' '</VirtualHost>' >> /opt/lampp/etc/extra/httpd-vhosts.conf

echo "================================================================="
echo "Virtual host '$dirName' was created"
echo "for the '$absolutePath' directory."
echo "================================================================="
echo ""


# Let's add our new host to /etc/hosts now
echo "================================================================="
echo "Let's add our new host to '/etc/hosts' now'."
echo "================================================================="
echo ""

printf '%s\n' '127.0.0.1   '$dirName'     www.'$dirName'' >> /etc/hosts
printf '%s\n' '127.0.0.1   '$dirName'     www.'$dirName''

echo "================================================================="
echo "All OK, move on."
echo "================================================================="
echo ""



# Let's generate a wp-config.php
echo "================================================================="
echo "Let's create a 'wp-config.php' file"
echo "================================================================="
echo ""

touch wp-config.php
mkdir -p config
cp $submoduleDir/wp-config-sample.php config/wordpress.php
printf '%s\n' '<?php' >> wp-config.php
printf '\t%s\n' 'require_once __DIR__ . "/config/wordpress.php";' >> wp-config.php

echo "Enter mySQL db name:"
read dbName
echo "Enter mySQL username:"
read dbUname

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/wordpress.php)
awk -v n=$wpcfgDBN -v s="define('DB_NAME', '$dbName');" 'NR == n {print s} {print}' config/wordpress.php > config/awk.php
wpcfgDBN=$(($wpcfgDBN + 1))
sed -i "${wpcfgDBN}d" config/awk.php

wpcfgDBU=$(awk '/DB_USER/{ print NR; exit }' config/awk.php)
awk -v n=$wpcfgDBU -v s="define('DB_USER', '$dbUname');" 'NR == n {print s} {print}' config/awk.php > config/awk1.php
wpcfgDBU=$(($wpcfgDBU + 1))
sed -i "${wpcfgDBU}d" config/awk1.php

wpcfgDBP=$(awk '/DB_PASSWORD/{ print NR; exit }' config/awk1.php)
awk -v n=$wpcfgDBP -v s="define('DB_PASSWORD', '');" 'NR == n {print s} {print}' config/awk1.php > config/awk2.php
wpcfgDBP=$(($wpcfgDBP + 1))
sed -i "${wpcfgDBP}d" config/awk2.php

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/awk2.php)
wpcfgDBN=$(($wpcfgDBN - 3))
awk -v n=$wpcfgDBN -v s="define('APP_ROOT', dirname(__DIR__));" 'NR == n {print s} {print}' config/awk2.php > config/awk3.php

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/awk3.php)
wpcfgDBN=$(($wpcfgDBN - 3))
awk -v n=$wpcfgDBN -v s="define('WP_HOME', 'http://$dirName');" 'NR == n {print s} {print}' config/awk3.php > config/awk4.php

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/awk4.php)
wpcfgDBN=$(($wpcfgDBN - 3))
awk -v n=$wpcfgDBN -v s="define('WP_SITEURL', WP_HOME . '/$submoduleDir/');" 'NR == n {print s} {print}' config/awk4.php > config/awk5.php

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/awk5.php)
wpcfgDBN=$(($wpcfgDBN - 3))
awk -v n=$wpcfgDBN -v s="define('WP_CONTENT_DIR', APP_ROOT . '/content/');" 'NR == n {print s} {print}' config/awk5.php > config/awk6.php

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/awk6.php)
wpcfgDBN=$(($wpcfgDBN - 3))
awk -v n=$wpcfgDBN -v s="define('WP_CONTENT_URL', WP_HOME . '/content/');" 'NR == n {print s} {print}' config/awk6.php > config/awk7.php

wpcfgDBN=$(awk '/DB_NAME/{ print NR; exit }' config/awk7.php)
wpcfgDBN=$(($wpcfgDBN - 3))
awk -v n=$wpcfgDBN -v s="define('WP_DEBUG', true);" 'NR == n {print s} {print}' config/awk7.php > config/awk8.php

mkdir -p content

rm config/wordpress.php
mv config/awk8.php config/wordpress.php
find . -type f -name awk\* -exec rm {} \;

# Config was created
echo "================================================================="
echo "Config files was created "
echo "================================================================="
echo ""


#Let's start to deal with the DB
echo "================================================================="
echo "Let's finally deal with DB"
echo "================================================================="
echo ""

/opt/lampp/lampp start
/opt/lampp/bin/mysql -h localhost -u $dbUname -e "CREATE DATABASE $dbName"

echo "================================================================="
echo "DataBase '$dbName' was created for 'dbUname' user."
echo "================================================================="
echo ""


# Let's set a right permissions for everithing
echo "================================================================="
echo "Setting right permissions & ownership."
echo "================================================================="
echo ""
chown $SUDO_USER:www-data -R $absolutePath


# Reboot/Run XAMPP
/opt/lampp/lampp restart


# start browser
xdg-open http://$dirName/$submoduleDir

