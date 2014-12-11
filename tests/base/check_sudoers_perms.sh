#!/bin/bash

check() {
	! ls -la /app/*/etc/sudoers | grep -v -- '-r--r-----'
}

error() {
	log "Имеются неправильные права на sudoers в одном из контейнеров"	
}
