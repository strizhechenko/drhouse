#!/bin/bash

check() {
	maxcount=1000
	if [ -d /app/xge ]; then
		maxcount=2000
		count=$(chroot /app/xge/ iptables-save | wc -l)
	fi
	count=$(iptables-save | wc -l)
	[ "$count" -le "$maxcount" ]
}

error() {
	log "Слишком большое количество правил iptables"	
}

. ./lib/drhouse drhouse_main
