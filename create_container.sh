docker run -it -d --restart always -e "SSL_DOMAIN=TESTING.COM" -e "IP_WEBDAV=IP_EXTERNAL" -e "HT_USER=put_your_user_here" -e "HT_PASSWORD=put_your_password_here" -p 443:443 -p 80:80 --name keeweb --hostname keeweb keeweb_nginx:latest
