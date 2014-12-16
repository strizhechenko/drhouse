#!/bin/bash

check() {
	. /cfg/config
	[ "${app['radius_voip.enabled']}" = '0' ] && return 0
	check_netstat "${app['radius_voip.ACC_IP']}:${app['radius_voip.ACC_PORT']}"
}

error() {
	log "Недоступен Radius-voip сервер (acc)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/angel main_critical
