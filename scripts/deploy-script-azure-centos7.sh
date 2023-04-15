# deploy script for centos 7 and azure vm

# 1 move artifact in local system common directory

# create backup of application

sudo rm -rf /var/www/html/node-app-bk
sudo mkdir -p /var/www/html/node-app-bk
sudo chmod -R 777 /var/www/html/node-app-bk

DIR="/var/www/html/node-app/" 

if [ "$(ls -A $DIR)" ]; then
    sudo mv /var/www/html/node-app/ /var/www/html/node-app-bk
else
    echo "$DIR is Empty"
fi 

# /home/kgoqxwdcao/artifacts/

sudo mkdir -p /var/www/html/node-app
sudo chmod -R 777 /var/www/html/node-app   
cd artifacts/
echo "Server Info : '$(cat /etc/centos-release)'." 
echo "shell is currently working in '$(pwd)'." 
sudo mv  publish.zip /var/www/html/node-app

# basic config for centos 8 system
sudo yum update -y 
 
# 2 install basic dependency
 
sudo yum install -y nano
sudo yum install epel-release -y
sudo yum install nodejs -y
sudo yum install npm -y
node --version
sudo npm i -g pm2
sudo npm install -g typescript 

# generate symlink , if not exist

sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl status httpd
# manage selinux policy
sudo yum install zip unzip -y

sudo setsebool -P httpd_unified 1
hostname -I

# 3 create apacahe error logs

sudo mkdir -p /var/www/logs/
sudo chmod -R 777 /var/www/logs/
cd /var/www/logs/ 

touch nodeapp-error.log
sudo chmod -R 777 /var/www/logs/
# less /var/log/httpd/error_log


# 4 setup application in local system

cd /var/www/html/node-app
unzip publish.zip
rm publish.zip
npm i --save
tsc
pm2 start pm2-apps.json

# 5 create vhost config
 
sudo chmod -R 777 /etc/httpd/conf.d
sudo cp /var/www/html/node-app/scripts/nodeAppVhost.conf  /etc/httpd/conf.d/nodeAppVhost.conf 
sudo cp /var/www/html/node-app/scripts/hosts  /etc/hosts

# 7 restart apacha server
 
sudo systemctl status httpd 
sudo systemctl restart httpd 
sudo systemctl status httpd 

sudo setsebool -P httpd_can_network_connect on
