#!/bin/bash

set -eux

# Fix NTP/Time
# https://github.com/boot2docker/boot2docker/issues/290
boot2docker ssh -- sudo killall -9 ntpd ntpclient || :
boot2docker ssh -- sudo ntpclient -s -h pool.ntp.org
boot2docker ssh -- sudo ntpd -p pool.ntp.org

# Set the TZ
# https://github.com/boot2docker/boot2docker/issues/476
scp -i ~/.ssh/id_boot2docker -P 2022 /etc/localtime docker@localhost:/tmp/
boot2docker ssh -- sudo cp /tmp/localtime /etc/localtime

# Create /data used for data-only containers and such
boot2docker ssh -- sudo mkdir -p /data
boot2docker ssh -- sudo chown 1000:1000 /data

# EOF
