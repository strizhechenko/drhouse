#!/bin/bash

check() {
	[ $(find /app/collector/var/stat/raw/ -type f | wc -l) != '0' ]
}

error() {
	log "Отсутствует сырая статистика"
}

. ./lib/drhouse drhouse_main_nosafemode
