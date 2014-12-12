#!/bin/bash

logfile=/var/log/reporter.log

check() {
	current_hour="$(date "+%Y-%m-%d %H")"
	count=$(grep -w "$current_hour.*ERROR" $logfile | wc -l)
	[ "$count" -le "0" ]
}

error() {
	log "Критические ошибки в логе $logfile"
}

. ./lib/drhouse drhouse_main_nosafemode
