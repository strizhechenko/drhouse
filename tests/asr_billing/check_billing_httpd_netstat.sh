#!/bin/bash

check() {
	. /cfg/config
	check_netstat "${app['apache.ip']}:${app['apache.port']}"
}

error() {
	log "Веб-интерфейс биллинга недоступен"
}

. /usr/local/lib/drhouse drhouse_main
