#!/bin/bash



check() {
	df -H | awk '{print $5}' | grep '[0-9]' | while read line; do
		[ "${line%%%}" -gt '90' ] && return 1
	done
}

error() {
	log "На одном из разделов мало свободного места"
	df -H	
}

. ./lib/drhouse drhouse_main
