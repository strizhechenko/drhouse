#!/bin/bash

check() {
	check_dns
}

error() {
	log "Не настроены DNS"	
}

. /app/base/usr/local/lib/angel main_critical
