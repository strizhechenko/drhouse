#!/bin/bash

check() {
	. /cfg/config
	ping -qc 1 -w 1 "${nfusens['collector']%%:*}" &>/dev/null
}

error() {
	log "Netflow-коллектор недоступен."
}

. ./lib/drhouse drhouse_main_nosafemode
