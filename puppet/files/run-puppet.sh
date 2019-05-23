#!/bin/bash
cd /etc/puppetlabs/code/environments/production && git fetch --tags -p && git reset --hard origin/master
/opt/puppetlabs/bin/puppet apply puppet/manifests/
