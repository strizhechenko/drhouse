#!/bin/bash

check() {
	. /cfg/config
	[ "${app['radius_wimax.enabled']}" = '0' ] && return 0
	check_netstat "${app['radius_wimax.ACC_IP']}:${app['radius_wimax.ACC_PORT']}"
}

error() {
	log "Недоступен Radius-wimax сервер (acc)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/drhouse drhouse_main
