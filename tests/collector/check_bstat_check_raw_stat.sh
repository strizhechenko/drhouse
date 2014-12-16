#!/bin/bash

check() {
	[ $(find /var/stat/raw/ -type f | wc -l) -le '1' ]
}

error() {
	log "Отсутствует сырая статистика"
}

. /usr/local/lib/drhouse drhouse_main_nosafemode
