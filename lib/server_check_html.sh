#!/bin/bash

/app/base/usr/local/bin/server_check.sh plaintext > /tmp/server_check.md
markdown /tmp/server_check.md
echo

echo "<h2>Свободное место на диске</h2>"
echo "<pre>"
df -H | egrep "(^/dev|[A-ZА-Яa-zа-я]%)"
echo "</pre>"

echo "<h2>Состояние памяти</h2>"
echo "<pre>"
free
echo "</pre>"

echo "<h2>Нагрузка на процессор(ы)</h2>"
echo "<pre>"
top -b -n1 | head -3
echo "</pre>"
