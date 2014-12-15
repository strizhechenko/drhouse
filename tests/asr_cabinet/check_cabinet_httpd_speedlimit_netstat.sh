#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['apache.speedlimitip']}:${app['apache.speedlimitport']}"
}

error() {
	log "Доступность страницы speedlimit"
}

fix() {
	/etc/init.d/httpd restart
}

. /usr/local/lib/drhouse drhouse_main_nosafemode
