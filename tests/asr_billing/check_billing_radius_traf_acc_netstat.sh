#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius_traf.ACC_IP']}:${app['radius_traf.ACC_PORT']}"
}

error() {
	log "Недоступен Radius-traf сервер (acc)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/angel main_critical
