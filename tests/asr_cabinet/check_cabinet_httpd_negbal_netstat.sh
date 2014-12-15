#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['apache.negbalip']}:${app['apache.negbalport']}"
}

error() {
	log "Веб-сервер negbal-страницы недоступен"
}

fix() {
	/etc/init.d/httpd restart
}

. /usr/local/lib/drhouse drhouse_main_nosafemode
