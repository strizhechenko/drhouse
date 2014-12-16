#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['apache.ip']}:${app['apache.port']}"
}

error() {
	log "Веб-сервер локального сайта недоступен"
}

fix() {
	/etc/init.d/httpd restart
}

. /usr/local/lib/angel main_critical
