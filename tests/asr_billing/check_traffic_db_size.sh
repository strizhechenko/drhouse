#!/bin/bash

check() {
	dbsize="$(du -sh /var/db/buff_traf.gdb | awk '{print $1}')"
	[ "$dbsize" -lt "$((10*1000*1000))" ]
}

error() {
	log "Чрезмерно большая база данных трафика"
}

. ./lib/drhouse drhouse_main
