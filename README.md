# How to build the image:

1. Enter to the git repo directory and execute:
```docker build -t "keeweb_nginx:1.0" .```

Or Execute:
```
sh build.sh
```
# How to create a container:
```docker run -it -d --restart always -e "SSL_DOMAIN=TESTING.COM" -e "IP_WEBDAV=10.1.32.200" -e "HT_USER=put_your_user_here" -e "HT_PASSWORD=put_your_password_here" -p 10.1.32.200:443:443 --name keeweb --hostname keeweb keeweb_nginx:1.0```
# keeweb_nginx
# keeweb_nginx
