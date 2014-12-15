#!/bin/bash

check() {
	. /cfg/config
	ping -qc 1 -w 1 "${nfusens['collector']%%:*}" &>/dev/null
}

error() {
	log "Netflow-коллектор недоступен."
}

. /usr/local/lib/drhouse drhouse_main_nosafemode
