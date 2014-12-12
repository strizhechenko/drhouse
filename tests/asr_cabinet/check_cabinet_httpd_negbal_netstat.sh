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

. ./lib/drhouse drhouse_main
