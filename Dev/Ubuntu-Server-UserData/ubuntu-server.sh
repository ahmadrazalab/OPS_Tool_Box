sudo apt update -y 
sudo apt upgrade -y 
# install php 8.2
sudo apt install software-properties-common -y 
sudo add-apt-repository ppa:ondrej/php
sudo apt update -y 
sudo apt install php8.2 -y 
sudo apt update -y  
# isntall php fpm and other extesions 
sudo apt install -y php8.2 php8.2-common php8.2-cli php8.2-fpm php8.2-mysql php8.2-mbstring php8.2-xml

# isntall mysql and setup my sql
sudo apt install mysql-server -y 

# isntall nodejs and npm and nvm modules 
sudo apt install nodejs -y 
sudo apt install npm -y 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install 18
nvm use 18
nvm alias default 18
# isntall yarn 
npm install -g yarn 
#install pm2
npm install -g pm2 
#installl composer 
sudo apt install composer -y 
#USe digital occena for new composer

# other setting 
sudo apt remove apache2 -y
sudo systemctl stop apache2
sudo systemctl disable apache2
sudo apt install nginx -y
sudo systemctl enable nginx 
sudo systemctl start nginx 
sudo systemctl status nginx 
# ssl for nginx only 
sudo snap install -y --classic certbot
sudo apt update -y 
sudo apt upgrade -y
