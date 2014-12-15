#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius_wimax.AUTH_IP']}:${app['radius_wimax.AUTH_PORT']}"
}

error() {
	log "Недоступен Radius-wimax сервер (auth)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/drhouse drhouse_main
