#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['radius_traf.AUTH_IP']}:${app['radius_traf.AUTH_PORT']}"
}

error() {
	log "Недоступен Radius-traf сервер (auth)"
}

fix() {
	/etc/init.d/radiusd restart
}

. /usr/local/lib/angel main_critical
