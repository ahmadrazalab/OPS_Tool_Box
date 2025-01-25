# Set php version default 
sudo update-alternatives --set php /usr/bin/php8.2
# load the default php confi file path and name 
php -i | grep "Loaded Configuration File"
# Increate php upload limit 
sudo nano /etc/php/8.2/fpm/php.ini   /   sudo nano /etc/php/8.2/cli/php.ini
upload_max_filesize = 50M
post_max_size = 50M
sudo systemctl restart php8.2-fpm