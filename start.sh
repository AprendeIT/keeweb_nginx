#!/bin/bash

if [ -z "$IP_WEBDAV"  ]
then
   echo "IP_WEBDAV is empty"
   exit
fi

mkdir /var/www/webdav/webdav
chown www-data:www-data -R /var/www/webdav/webdav

cat > /var/www/keeweb/default_config.json <<EOF
{
	"settings": {
		"theme": "fb",
		"locale": "es-ES",
		"expandGroups": true,
		"listViewWidth": null,
		"menuViewWidth": null,
		"tagsViewHeight": null,
		"autoUpdate": "install",
		"clipboardSeconds": 0,
		"autoSave": true,
		"autoSaveInterval": 1,
		"rememberKeyFiles": "data",
		"idleMinutes": 5,
		"minimizeOnClose": false,
		"tableView": false,
		"colorfulIcons": true,
		"titlebarStyle": "default",
		"lockOnMinimize": true,
		"lockOnCopy": false,
		"lockOnAutoType": false,
		"lockOnOsLock": false,
		"helpTipCopyShown": false,
		"templateHelpShown": false,
		"skipOpenLocalWarn": false,
		"hideEmptyFields": false,
		"skipHttpsWarning": false,
		"demoOpened": false,
		"fontSize": 2,
		"tableViewColumns": null,
		"generatorPresets": null,
		"cacheConfigSettings": false,
		"canOpen": true,
		"canOpenDemo": true,
		"canOpenSettings": true,
		"canCreate": true,
		"canImportXml": true,
		"canRemoveLatest": true,
		"dropbox": false,
		"webdav": true,
		"gdrive": false,
		"onedrive": false
	},
	"plugins": [
		{"url": "https://plugins.keeweb.info/translations/es-ES"}
	],
	"files": [
		{
			"storage": "webdav", 
			"name": "Keepass1", 
			"path": "https://$IP_WEBDAV/webdav/Keepass1.kdbx",
			"options": { "user": "$HT_USER", "password": "$HT_PASSWORD" }
		}
	]
}
EOF


#IF CERT VAR OR CERT FILE DONT EXISTS
if [ ! -z "$SSL_DOMAIN" ] && [ ! -f /etc/nginx/external/cert.pem ]
then
    openssl req -x509 -nodes -days 1000 -newkey rsa:4096 -keyout /etc/nginx/external/key.pem -out /etc/nginx/external/cert.pem -subj '/CN=$SSL_DOMAIN/O=$SSL_DOMAIN./C=US'\
    && openssl dhparam -out /etc/nginx/external/dh.pem 2048
fi

if [ ! -z "$HT_PASSWORD" ] && [ ! -z "$HT_USER" ] 
then
    echo $HT_PASSWORD | htpasswd -c -i /etc/nginx/external/.passwords.list $HT_USER
    nginx
    while true;do sleep 30;done
else
    echo "I can't be up because HT_PASSWORD or HT_USER is not defined"
    exit
fi


