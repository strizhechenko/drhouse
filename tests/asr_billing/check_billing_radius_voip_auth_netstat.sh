#!/bin/bash

check() {
	. /cfg/config
	[ "${app['radius_voip.enabled']}" = '0' ] && return 0
	check_netstat "${app['radius_voip.AUTH_IP']}:${app['radius_voip.AUTH_PORT']}"
}

error() {
	log "Недоступен Radius-voip сервер (auth)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/drhouse drhouse_main
