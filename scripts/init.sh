#!/bin/sh
msg(){
    echo -e '\0033\0143'
    echo "\nCTRL + C exists docker applications\n"
    echo "\nApplication: http://localhost:8080/\n"
    echo "\nAdminer : http://localhost:8080/adminer.php\n"
    echo "\nInfo page: http://localhost:8080/info.php\n"
}

#start mysql
mkdir -p /var/run/mysqld/
touch /var/run/mysqld/mysqld.sock
touch /var/run/mysqld/mysqld.pid
chmod -R 644 /var/run/mysqld/mysqld.sock
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
service mysql start 2>/dev/null
#create user
mysql -e "GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'qwerty123#' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"
#start nginx
rm /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/local_site /etc/nginx/sites-enabled/local_site
mkdir -p /run/php && touch /run/php/php7.0-fpm.sock
service php7.0-fpm start 2>/dev/null
service nginx start 2>/dev/null
curl -s -o /var/www/html/adminer.php -L "http://www.adminer.org/latest-mysql-en.php"

#setup php
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini

while :
do
	msg
    sleep 1    
done