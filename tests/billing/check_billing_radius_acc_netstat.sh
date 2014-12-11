#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius.ACC_IP']}:${app['radius.ACC_PORT']}"
}

error() {
	log "Недоступен Radius сервер (acc)"
}

fix() {
	/etc/init.d/radiusd restart
}

. ./lib/drhouse drhouse_main
