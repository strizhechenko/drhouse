#!/bin/bash



check() {
	while IFS=$IFS: read var val tmp; do
		eval "$var=$val"
	done <<< "$(sed -e 's/(.*)//g' /proc/meminfo)"
	TotalMem=$((MemTotal+SwapTotal))
	BufCache=$((Buffers+Cached))
	FreeMem=$((100 - (TotalMem-SwapFree-BufCache)*100 / TotalMem))
	[ $FreeMem -gt 20 ]
}

error() {
	log "Мало свободной памяти"	
}

. /app/base/usr/local/lib/drhouse drhouse_main
