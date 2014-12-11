#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius_wimax.ACC_IP']}:${app['radius_wimax.ACC_PORT']}"
}

error() {
	log "Недоступен Radius-wimax сервер (acc)"
}

fix() {
	/etc/init.d/radiusd restart
}

. ./lib/drhouse drhouse_main
