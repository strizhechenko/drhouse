#!/bin/bash

check() {
	check_dns
}

error() {
	log "Не настроены DNS"	
}

. /app/base/usr/local/lib/drhouse drhouse_main
