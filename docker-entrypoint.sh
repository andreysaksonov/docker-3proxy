#!/bin/bash

if [ "$1" = "start_proxy" ]; then
if [ ! -f /etc/3proxy/cfg/3proxy.cfg ]; then
    if [ -z "$PROXY_LOGIN" ] || [ -z "$PROXY_PASSWORD" ]; then
			echo >&2 'error: proxy is uninitialized, variables is not specified '
			echo >&2 '  You need to specify PROXY_LOGIN and PROXY_PASSWORD'
			exit 1
    fi
	echo "
nserver 1.1.1.1
nserver 8.8.8.8
nserver 8.8.4.4
nscache 65536
nsrecord www.porno.com 127.0.0.1

log
logformat "L%C - %U [%d/%o/%Y:%H:%M:%S %z] ""%T"" %E %I %O %N/%R:%r"

monitor /etc/3proxy/cfg/3proxy.cfg

users $PROXY_LOGIN:CL:$PROXY_PASSWORD

auth strong
proxy -p3128
socks -p1080
admin -p8080 -w

flush
" > /etc/3proxy/cfg/3proxy.cfg
	echo "Proxy user login:         $PROXY_LOGIN"
	echo "Proxy user password:      $PROXY_PASSWORD"
	echo "Proxy process started!"
	/etc/3proxy/3proxy /etc/3proxy/cfg/3proxy.cfg
fi
else
	exec "$@"
fi

	
