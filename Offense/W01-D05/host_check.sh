#!/usr/bin/env bash

for target in 127.0.0.1 192.168.1.10 10.0.0.5; do
	echo "Checking $target ..."

	if ping -c 1 -W 2 "$target" > /dev/null 2>&1; then
		echo "[+] $target is responding"
	else
		echo "[-] $target did not respond"
	fi
	
	echo
done
