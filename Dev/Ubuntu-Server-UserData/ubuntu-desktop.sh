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
sudo apt update -y 
sudo apt upgrade -y 
sudo apt install nginx -y
sudo systemctl enable nginx 
sudo systemctl start nginx 
sudo systemctl status nginx 
# ssl for nginx only 
sudo snap install -y --classic certbot
sudo apt update -y 
sudo apt upgrade -y


################################################################
# DESTOP SOFTWARE available in folder or via repositories
#########
# Update package list
sudo apt update -y 
sudo apt upgrade -y  
# Install Chrome
#sudo apt install google-chrome-stable -y 
# Install VSCode
sudo snap install code --classic 
# Install Terminus
# download package deb file
# isntall dpkg -i package
# Install Terminator terminal
sudo apt install terminator -y 
# Install MySQL Workbench
sudo apt install mysql-workbench -y 
# Install OBS Studio
sudo apt install obs-studio -y 
# Install Postman
sudo snap install postman -y 
# Install Nginx
sudo apt install nginx -y 
# Install Docker and Docker Compose
sudo apt install docker.io docker-compose -y
# Install Minikube with Dashboards
#sudo apt install minikube
minikube addons enable dashboard
# Install Net-tools and other networking tools
sudo apt install net-tools iputils-ping traceroute -y 
# Install Terraform
sudo apt-add-repository --yes --update ppa:hashicorp/terraform
sudo apt install terraform -y 
# Install Ansible
sudo apt install ansible -y 
# Install AWS CLI
sudo apt install awscli -y 
# Install PostgreSQL CLI (psql)
sudo apt install postgresql-client -y 
# Additional utilities
sudo apt install curl wget -y 
# Verify Docker permissions (add your user to the docker group)
sudo usermod -aG docker $USER
# Reboot for changes to take effect

####################################################### other utilities 
sudo apt update -y 
sudo apt upgrade -y 
# Install File Compression/Extraction Tools
sudo apt install unzip zip unrar -y 
# Install Git Version Control
sudo apt install git -y 
# Install Text Editors
sudo apt install vim nano -y 
# Install htop (Interactive Process Viewer)
sudo apt install htop -y 
# Install Tree (View Directory Structure)
sudo apt install tree -y 
# Install jq (JSON Processor)
sudo apt install jq -y 
# Install VLC Media Player
sudo apt install vlc -y 
# Install OpenSSH Server (if you need SSH access)
sudo apt install openssh-server -y 






# REBOOT for changes to take effect
sudo reboot 

