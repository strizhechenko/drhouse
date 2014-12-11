#!/bin/bash



check() {
	! df -i | grep 9[0-9]%
}

error() {
	log "На одном из устройств осталось мало свободных inode"	
	log "Возможно какая-то папка забита большим кол-вом файлов"
}

. ./lib/drhouse drhouse_main
