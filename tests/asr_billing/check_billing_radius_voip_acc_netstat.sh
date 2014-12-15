#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius_voip.ACC_IP']}:${app['radius_voip.ACC_PORT']}"
}

error() {
	log "Недоступен Radius-voip сервер (acc)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/drhouse drhouse_main
