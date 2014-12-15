#!/bin/bash

check() {
	check_dns
}

error() {
	log "Не настроены DNS"	
}

. /usr/local/lib/drhouse drhouse_main
