#!/bin/sh

rm -f /etc/env
for varname in `env | grep -o "^[A-Z_0-9]*"`; do
  echo "$varname=\"`printenv $varname`\"" >> /etc/env
done

if [ -z "$1" ]; then
  echo Running scripts in /etc/startup
  run-parts /etc/startup

  echo Starting services in /etc/services
  set -- runsvdir -P /etc/services
fi

exec $@
