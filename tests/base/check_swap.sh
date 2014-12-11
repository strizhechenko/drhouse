#!/bin/bash

check() {
	! free | grep -q 'Swap.*0 *0 *0'
}

error() {
	log "В идеале добавить бы в /etc/fstab строчку:"
	log UUID=$(ls -la /dev/disk/by-uuid/ | grep 7$ | egrep -o "[a-z0-9-]+-[a-z0-9]*") none swap sw 0 0
	log "Но не факт что это именно тот раздел который должен быть swap"
}
