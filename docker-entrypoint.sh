#!/bin/bash
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if [ -f tmp/pids/unicorn.pid ]; then
  rm tmp/pids/unicorn.pid
fi
bundle check || bundle install
exec "$@"