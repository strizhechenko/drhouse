#!/bin/bash

check() {
	count="$(/usr/local/bin/xgesh session list | grep -cv '^$')"
}

error() {
	[ "$count" != '0' -a "$count" -lt "1000000" ]
}

. ./lib/drhouse drhouse_main_nosafemode
