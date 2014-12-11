#!/bin/bash

check() {
	dmesg | grep -q 'FATAL: Could not load /lib/modules' && return 1
	dmesg | grep -q 'ip_tables: Unknown symbol' && return 1
	dmesg | grep -q 'ip_tables: disagrees about version of symbol' && return 1
}

error() {
	echo "Версия ядра несовместима с версией модулей"
}
