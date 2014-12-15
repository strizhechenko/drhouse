#!/bin/bash



check() {
	cpu_idle=$(top -b -n 1 | grep -o [0-9.]*%id | cut -d '.' -f1)
	[ $cpu_idle -gt 10 ]
}

error() {
	log "Высокая нагрузка на CPU"	
}

. /app/base/usr/local/lib/drhouse drhouse_main
