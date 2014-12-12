#!/bin/bash

check() {
	count=$(grep -w "$(date  "+%Y-%m-%d %H").*CRITICAL" /app/asr_billing/var/log/worker.log | wc -l)
	[ "$count" -le "0" ]
}

error() {
	log "Имеются критические ошибки в логе worker за последний час."
}

. ./lib/drhouse drhouse_main
