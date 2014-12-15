#!/bin/bash

check() {
	check_netstat nf_collector
}

error() {
	log "Netflow Collector не запущен"
}

fix() {
	/etc/init.d/nf_collector restart	
}

. /app/base/usr/local/lib/drhouse drhouse_main_nosafemode
