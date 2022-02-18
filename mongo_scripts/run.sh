#!/bin/bash
set -m

mongodb_cmd="mongod"
cmd="$mongodb_cmd --bind_ip_all"

if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_pwd.sh
fi

fg
