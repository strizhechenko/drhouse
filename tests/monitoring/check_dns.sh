#!/bin/bash

check() {
	check_dns
}

error() {
	log "Не настроены DNS"	
}

. ./lib/drhouse drhouse_main
