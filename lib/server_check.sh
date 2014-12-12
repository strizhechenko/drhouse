#!/bin/bash

. /etc/init.d/functions

if [ "$1" = 'plaintext' ]; then
	SETCOLOR_SUCCESS=
	SETCOLOR_FAILURE=
	SETCOLOR_WARNING=
	SETCOLOR_NORMAL=
	MOVE_TO_COL=
fi

h1() {
	echo "# $@"
	echo
}

list() {
	echo -n "- $@"
}

run_test() {
	func="$1"
	shift
	$func $@ && echo_success || echo_failure
	echo
}

free_inodes() {
	list "Свободные inode"
	! df -i | grep 9[0-9]%
}

swap_enabled() {
	list "Наличие swap"
	free | grep -q 'Swap.*0 *0 *0' || return 0
	echo "В идеале добавить бы в /etc/fstab строчку:"
	echo UUID=$(ls -la /dev/disk/by-uuid/ | grep 7$ | egrep -o "[a-z0-9-]+-[a-z0-9]*") none swap sw 0 0
	echo "Но не факт что это именно тот раздел который должен быть swap"
<<<<<<< HEAD
	echo "Плюс в fstab может уже быть запись о нём, но немного неправильная"
=======
	echo "Плюс в fstab может уже быть запись о нём, но немного неправильная (другой UUID)"
>>>>>>> 47a731b92b1d0b9ca84e8a56c7f8449f0da6c7a5
	return 1
}

file_perms() {
	list "Права на системные файлы"
	ls -la /app/*/etc/sudoers | grep -v -- '-r--r-----' && return 1
	return 0
}

freemem_check() {
	list "Объем свободной памяти + swap"
<<<<<<< HEAD
	# awk by nikolay
	totalmem=$(($(egrep "(Swap|Mem)Total" /proc/meminfo | awk '{sum += $2} END {print sum}')))
	freemem=$(($(egrep "(Swap|Mem)Free" /proc/meminfo | awk '{sum += $2} END {print sum}')))
	echo -n " = $((freemem * 100 / totalmem))%"
	[ $((freemem * 100 / totalmem)) -gt 20 ]
=======
	while IFS=$IFS: read var val tmp; do
		eval "$var=$val"
	done <<< "$(sed -e 's/(.*)//g' /proc/meminfo)"
	TotalMem=$((MemTotal+SwapTotal))
	BufCache=$((Buffers+Cached))
	FreeMem=$((100 - (TotalMem-SwapFree-BufCache)*100 / TotalMem))

	echo -n "= ${FreeMem}%"
	[ $FreeMem -gt 20 ]
>>>>>>> 47a731b92b1d0b9ca84e8a56c7f8449f0da6c7a5
}

cpu_load_check() {
	list "Нагрузка на процессор"
	cpu_idle=$(top -b -n 1 | grep -o [0-9.]*%id | cut -d '.' -f1)
	echo -n " (в бездействии $cpu_idle% времени)"
	[ $cpu_idle -gt 10 ]
}

disk_usage() {
	list "Свободное место на дисках"
	df -H | awk '{print $5}' | grep '[0-9]' | while read line; do
		[ "${line%%%}" -gt '95' ] && df -H && return 1
	done
	return 0
}

netstat_check() {
	netstat -lnp | grep -qw "$1"
}


auth_httpd_netstat() {
	. /app/auth/cfg/config
	list "Веб-сервер системы авторизации:"
	netstat_check "${app['apache.ip']}:${app['apache.port']}"
}



billing_httpd_netstat() {
	. /app/asr_billing/cfg/config
	list "Веб-интерфейс биллинга:"
	netstat_check "${app['apache.ip']}:${app['apache.port']}"
}

base_httpd_netstat() {
	. /app/base/cfg/config
	list "Базовый httpd:"
	netstat_check "${app['apache.ip']}:${app['apache.port']}"
}

cabinet_httpd_netstat() {
	. /app/asr_cabinet/cfg/config
	list "HTTPD личного кабинета:"
	netstat_check "${app['apache.ip']}:${app['apache.port']}"
}

fiscal_httpd_netstat() {
	. /app/asr_fiscal/cfg/config
	list "HTTPD платёжных систем (http):"
	netstat_check "${app['apache.ip']}:${app['apache.port']}"
}

fiscal_httpd_ssl_netstat() {
	. /app/asr_fiscal/cfg/config
	list "HTTPD платёжных систем (https):"
	netstat_check "${app['apache.sslip']}:${app['apache.sslport']}"
}

cabinet_httpd_negbal_netstat() {
	. /app/asr_cabinet/cfg/config
	list "HTTPD личного кабинета (отрицательный баланс):"
	netstat_check "${app['apache.negbalip']}:${app['apache.negbalport']}"
}

cabinet_httpd_speedlimit_netstat() {
	. /app/asr_cabinet/cfg/config
	list "HTTPD личного кабинета (ограничение скорости):"
	netstat_check "${app['apache.speedlimitip']}:${app['apache.speedlimitport']}"
}

billing_radius_auth_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-сервер (авторизация)"
	netstat_check "${app['radius.AUTH_IP']}:${app['radius.AUTH_PORT']}"
}

billing_radius_acc_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-сервер (аккаунтинг)"
	netstat_check "${app['radius.ACC_IP']}:${app['radius.ACC_PORT']}"
}

billing_radius_voip_auth_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-voip-сервер (авторизация)"
	daemon=radius_voip
	[ "${app[$daemon.enabled]}" = '0' ] && echo -n "(отключен)" && return 0
	netstat_check "${app[$daemon.AUTH_IP]}:${app[$daemon.AUTH_PORT]}"
}

billing_radius_voip_acc_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-voip-сервер (аккаунтинг)"
	daemon=radius_voip
	[ "${app[$daemon.enabled]}" = '0' ] && echo -n "(отключен)" && return 0
	netstat_check "${app[$daemon.ACC_IP]}:${app[$daemon.ACC_PORT]}"
}

billing_radius_wimax_auth_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-wimax-сервер (авторизация)"
	daemon=radius_wimax
	[ "${app[$daemon.enabled]}" = '0' ] && echo -n "(отключен)" && return 0
	netstat_check "${app[$daemon.AUTH_IP]}:${app[$daemon.AUTH_PORT]}"
}

billing_radius_wimax_acc_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-wimax-сервер (аккаунтинг)"
	daemon=radius_wimax
	[ "${app[$daemon.enabled]}" = '0' ] && echo -n "(отключен)" && return 0
	netstat_check "${app[$daemon.ACC_IP]}:${app[$daemon.ACC_PORT]}"
}

billing_radius_traf_auth_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-traf-сервер (авторизация)"
	netstat_check "${app['radius_traf.AUTH_IP']}:${app['radius_traf.AUTH_PORT']}"
}

billing_radius_traf_acc_netstat() {
	. /app/asr_billing/cfg/config
	list "Radius-traf-сервер (аккаунтинг)"
	netstat_check "${app['radius_traf.ACC_IP']}:${app['radius_traf.ACC_PORT']}"
}

inet_access() {
	list "Доступ к сети"
	ping -c 1 8.8.8.8 &>/dev/null
}

billing_db_size() {
	list "Размер основной базы данных"
	dbsize="$(du -sh /app/asr_billing/var/db/billing.gdb | awk '{print $1}')"
	echo -n " ($dbsize)"
	[ "$(du -s /app/asr_billing/var/db/billing.gdb | awk '{print $1}')" -lt "$((10*1000*1000))" ]
}

traffic_db_size() {
	list "Размер основной базы данных"
	dbsize="$(du -sh /app/asr_billing/var/db/buff_traf.gdb | awk '{print $1}')"
	echo -n " ($dbsize)"
	[ "$(du -s /app/asr_billing/var/db/buff_traf.gdb | awk '{print $1}')" -lt "$((10*1000*1000))" ]
}

check_critical_worker() {
	list "Критические ошибки в логе worker за последний час: "
	maxcount=0
	count=$(grep -w "$(date  "+%Y-%m-%d %H").*CRITICAL" /app/asr_billing/var/log/worker.log | wc -l)
	echo -n "$count"
	[ "$count" -le "$maxcount" ]
}

iptables_rules_count() {
	list "Количество правил iptables: "
	maxcount=1000
	[ -d /app/xge ] && maxcount=2000
	[ -d /app/xge ] && count=$(chroot /app/xge/ iptables-save | wc -l) || count=$(iptables-save | wc -l)
	echo -n "$count"
	[ "$count" -le "$maxcount" ]
}

xge_session_count() {
	list "Количество пользовательских сессий: "
	count="$(chroot /app/xge/ /usr/local/bin/xgesh session list | grep -cv '^$')"
	echo -n $count
	[ "$count" != '0' -a "$count" -lt "1000000" ]
}

server_state() {
	h1 "Состояние сервера"
	run_test freemem_check
	run_test cpu_load_check
	run_test inet_access
	run_test disk_usage
	run_test file_perms
	run_test swap_enabled
	run_test free_inodes
	return 0
}

cabinet() {
	h1 "Личный кабинет"
	run_test cabinet_httpd_netstat
	run_test cabinet_httpd_negbal_netstat
	run_test cabinet_httpd_speedlimit_netstat
	run_test check_chroot_dns asr_cabinet
	return 0
}

fiscal() {
	h1 "Платёжные системы"
	run_test fiscal_httpd_netstat
	run_test fiscal_httpd_ssl_netstat
	run_test check_chroot_dns asr_fiscal
	return 0
}

check_app() {
	[ -f /app/$1/cfg/config -o -f /app/asr_$1/cfg/config -o "$1" = 'server_state' ] || return 0
	$1
	echo
}

run_custom() {
	[ "$#" = 0 ] && return 0
	grep -q "^$1() {$" "$0" || return 0
	$1
	exit
}

main() {
	run_custom $@
	check_app cabinet
	check_app collector
	check_app fiscal
	check_app xge
	check_app server_state
}

main $@
