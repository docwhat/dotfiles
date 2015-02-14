#!/bin/bash

set -eu

echo 'Set the time zone.'
echo '    https://github.com/boot2docker/boot2docker/issues/476'
scp -qi ~/.ssh/id_boot2docker -P 2022 /etc/localtime docker@localhost:/tmp/
boot2docker ssh -- sudo cp /tmp/localtime /etc/localtime


echo 'Create /data used for volume data.'
boot2docker ssh -- sudo mkdir -p /data
boot2docker ssh -- sudo chown 1000:1000 /data

# EOF
