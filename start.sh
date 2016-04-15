#!/bin/bash
# This is our first script.

echo 'Begin start.sh...'

# You can add any command you need here:

# Start ssh server
/usr/sbin/sshd -D

echo 'start.sh ended.'