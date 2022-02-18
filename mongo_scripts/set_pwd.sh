#!/bin/bash

MONGO_APPLICATION_DATABASE=${MONGO_APPLICATION_DATABASE:-"testdb"}

# Wait for MONGO to boot
RET=1
echo "=> Waiting for confirmation of MONGO service startup"
while [[ RET -ne 0 ]]; do
    echo "."
    sleep 1
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "wait 5 seconds..."
sleep 5

MONGO_ADMIN_USER=${MONGO_ADMIN_USER:-"admin"}
MONGO_ADMIN_PASSWORD=${MONGO_ADMIN_PASSWORD:-"adminpwd"}
mongo admin --eval "db.createUser({user: '$MONGO_ADMIN_USER', pwd: '$MONGO_ADMIN_PASSWORD', roles:[{role:'root',db:'admin'}]});"

IFS=',' read -ra DB <<< "$MONGO_APPLICATION_DATABASE"
echo "=> Creating a lot of DB ${DB}"

for var in ${DB[@]}
do
    if [ "$var" != "admin" ]; then
        echo "=> Creating a ${var} database user with a password in MONGO"
        MONGO_APPLICATION_USER=$(eval "echo \$$(printf 'MONGO_%s_USER' $(echo ${var:-"user"} | tr '[a-z]' '[A-Z]'))")
        MONGO_APPLICATION_PASS=$(eval "echo \$$(printf 'MONGO_%s_PASSWORD' $(echo ${var:-"userpwd"} | tr '[a-z]' '[A-Z]'))")
        mongo admin --username $MONGO_ADMIN_USER --password $MONGO_ADMIN_PASSWORD << EOF
use $var
db.createUser({user: '$MONGO_APPLICATION_USER', pwd: '$MONGO_APPLICATION_PASS', roles:[{role:'dbOwner', db:'$var'}]})
EOF
    fi
done

sleep 1

touch /data/db/.MONGO_password_set

echo "MONGO configured successfully. You may now connect to the DB."
