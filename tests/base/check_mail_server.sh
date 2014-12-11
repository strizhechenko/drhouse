#!/bin/bash

check() {
	check_netstat "\d*.\d*.\d*.\d*:25"
}

error() {
	log "Почтовый сервер не слушает на 25 порту"	
}

fix() {
	/etc/init.d/postfix restart	
}
