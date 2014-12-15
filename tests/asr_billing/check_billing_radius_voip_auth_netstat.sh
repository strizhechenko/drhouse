#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius_voip.AUTH_IP']}:${app['radius_voip.AUTH_PORT']}"
}

error() {
	log "Недоступен Radius-voip сервер (auth)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/drhouse drhouse_main
