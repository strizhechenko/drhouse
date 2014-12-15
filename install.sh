#!/bin/bash

for i in $(ls ./tests); do
	cp -av ./bin/* /app/$i/usr/local/bin/
	rm -vrf /app/$i/usr/local/drhouse_tests
	if [ "$i" != 'base' ]; then
		rm -vf /app/$i/usr/local/bin/drhouse_base
	else
		mv -vf /app/$i/usr/local/bin/drhouse{_base,}
	fi
	cp -av ./tests/$i /app/$i/usr/local/drhouse_tests
	cp -av ./lib/drhouse /app/$i/usr/local/lib/drhouse
done
