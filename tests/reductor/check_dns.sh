#!/bin/bash

check() {
	check_dns
}

error() {
	log "Не настроены DNS"	
}

. ./lib/angel main_critical
