# HOW TO without Docker compose

## build the image without docker compose:

Enter to the git repo directory and execute:
```docker build -t "keeweb_nginx:latest" .```

Or Execute:
```
sh build.sh
```
## How to create a container:
<pre>
docker run -it -d --restart always -e "SSL_DOMAIN=TESTING.COM" -e "IP_WEBDAV=WRITE_THE_IP" -e "HT_USER=put_your_user_here" -e "HT_PASSWORD=put_your_password_here" -p 443:443 -p 80:80--name keeweb --hostname keeweb keeweb_nginx:latest
</pre>

if you need to create the config file default_config.json (/var/www/keeweb/default_config.json) in order to load https://IP/?cnfig=default_config.json with all the webdav config you have to set the variable:
PRODUCTION_EXTERNAL=1

# HOW TO with docker compose

## BUILD the image
You have to execute the following commands:

<pre>
cd keeweb_nginx
docker compose build
</pre>

## Creating the containers

You have to edit the file named “docker_compose.yml” by setting the following variables:

- HT_USER: WEBDAV USER
- HT_PASSWORD: WEBDAV PASSWORD
- IP_WEBDAV: WEBDAV IP (External)
- SSL_DOMAIN: Domain to set up the self-signed certificate
- PRODUCTION_EXTERNAL: if is set to 0 make a new file default_config.json, for don't make a new config file, set the var equal 1. For production must be set as 1.
