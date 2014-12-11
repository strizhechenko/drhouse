#!/bin/bash

check() {
	. /app/base/cfg/config
	check_netstat "${app['apache.ip']}:${app['apache.port']}"
}

error() {
	log "Базовый httpd недоступен"	
}

fix() {
	/etc/init.d/httpd restart	
}

. ./lib/drhouse drhouse_main
