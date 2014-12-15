#!/bin/bash

for i in $(ls ./tests); do
	cp -av ./bin/* /app/$i/usr/local/bin/
	rm -vrf /app/$i/usr/local/drhouse_tests
	cp -av ./tests/$i /app/$i/usr/local/drhouse_tests
	cp -av ./lib/drhouse /app/$i/usr/local/lib/drhouse
done
