#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['apache.ip']}:${app['apache.port']}"
}

error() {
	log "Недоступен веб-сервер авторизации"	
}

fix() {
	/etc/init.d/httpd restart	
}
