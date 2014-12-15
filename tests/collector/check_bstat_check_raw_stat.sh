#!/bin/bash

check() {
	[ $(find /app/collector/var/stat/raw/ -type f | wc -l) != '0' ]
}

error() {
	log "Отсутствует сырая статистика"
}

. /app/base/usr/local/lib/drhouse drhouse_main_nosafemode
