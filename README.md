# HOW TO without Docket compose

## build the image without docker compose:

1. Enter to the git repo directory and execute:
```docker build -t "keeweb_nginx:latest" .```

Or Execute:
```
sh build.sh
```
## How to create a container:
```docker run -it -d --restart always -e "SSL_DOMAIN=TESTING.COM" -e "IP_WEBDAV=WRITE_THE_IP" -e "HT_USER=put_your_user_here" -e "HT_PASSWORD=put_your_password_here" -p 443:443 -p 80:80--name keeweb --hostname keeweb keeweb_nginx:latest```

# HOW TO with docker compose

## BUILD the image
You have to execute the following commands:

cd keeweb_nginx
docker compose build

## Creating the containers

You have to edit the file named “docker_compose.yml” by setting the following variables:

- HT_USER: WEBDAV USER
- HT_PASSWORD: WEBDAV PASSWORD
- IP_WEBDAV: WEBDAV IP (External)
- SSL_DOMAIN: Domain to set up the self-signed certificate
