#!/bin/bash

check() {
	. /cfg/config
	[ "${app['radius_wimax.enabled']}" = '0' ] && return 0
	check_netstat "${app['radius_wimax.AUTH_IP']}:${app['radius_wimax.AUTH_PORT']}"
}

error() {
	log "Недоступен Radius-wimax сервер (auth)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/angel main_critical
