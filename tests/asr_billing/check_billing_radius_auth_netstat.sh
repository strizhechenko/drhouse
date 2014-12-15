#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius.AUTH_IP']}:${app['radius.AUTH_PORT']}"
}

error() {
	log "Недоступен Radius сервер (auth)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/drhouse drhouse_main
