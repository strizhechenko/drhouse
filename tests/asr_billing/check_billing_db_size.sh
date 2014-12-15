#!/bin/bash

check() {
	dbsize="$(du -sh /var/db/billing.gdb | awk '{print $1}')"
	[ "$dbsize" -lt "$((10*1000*1000))" ]
}

error() {
	log "Чрезмерно большая база данных биллинга"
}

. /usr/local/lib/drhouse drhouse_main
