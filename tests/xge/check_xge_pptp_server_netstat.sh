#!/bin/bash

check() {
	check_netstat 0.0.0.0:1723
}

error() {
	log "Не запущен l2tp-сервер"
}

fix() {
	/etc/init.d/accel-pppd restart
}

. ./lib/drhouse drhouse_main
