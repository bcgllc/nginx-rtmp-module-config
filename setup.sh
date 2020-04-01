echo 'Updating system'

apt --assume-yes update
apt --assume-yes upgrade

echo 'Install prerequisites'

apt-get --assume-yes install build-essential libpcre3 libpcre3-dev libssl-dev

echo 'Install NGINX'

apt install --assume-yes nginx

echo 'Update firewall settings'

ufw app list
ufw allow 'Nginx HTTP'
ufw status

echo 'Enable NGINX as a startup service'

systemctl enable nginx

echo 'Install unzip'

apt --assume-yes install unzip

echo 'Install nginx-rtmp-module'

apt --assume-yes install libnginx-mod-rtmp -y

echo 'Install stunnel4'

apt --assume-yes install stunnel4
mkdir /etc/stunnel/conf.d

echo 'Copy files'

mkdir /etc/nginx/conf
mkdir /etc/nginx/conf/rtmp

cp nginx.conf /etc/nginx/nginx.conf
cp nginx_customer_rtmp.conf /etc/nginx/conf/rtmp/nginx_customer_rtmp.conf
cp stunnel.conf /etc/stunnel/stunnel.conf
cp fb.conf /etc/stunnel/conf.d/fb.conf
cp stunnel4 /etc/default/stunnel4

echo 'Done copying files'

echo 'Restarting stunnel'
systemctl restart stunnel4
systemctl status stunnel4

echo 'Restarting NGINX'

systemctl stop nginx
systemctl start nginx
systemctl status nginx

echo 'Done'
echo ''
echo 'TODO: update stream URLs and stream keys and rename /etc/nginx/conf/rtmp/nginx_customer_rtmp.conf'
echo 'Afterwards, start nginx with the following command'
echo 'systemctl start nginx'
