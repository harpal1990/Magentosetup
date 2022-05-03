#!/bin/bash

cd /tmp/
/usr/bin/wget http://download.redis.io/releases/redis-stable.tar.gz
/bin/tar xzf redis-stable.tar.gz
cd redis-stable
make
make install
cd utils
/usr/bin/expect <<EOF
spawn bash install_server.sh
expect "6379"
send "6379\n"
expect "/etc/redis/6379.conf"
send "/etc/redis/redis.conf\n"
expect "/var/log/redis_6379.log"
send "/var/log/redis/redis.log\n"
expect "/var/lib/redis/6379"
send "/var/lib/redis/\n"
expect "/usr/local/bin/redis-server"
send "/usr/local/bin/redis-server\n"
expect "Then press ENTER to go on or Ctrl-C to abort."
send "\r"
interact
sleep 15
EOF

/etc/init.d/redis_6379 stop
/etc/init.d/redis_6379 start

