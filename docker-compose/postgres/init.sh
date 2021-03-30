#!/bin/sh

set -eu

psql -v ON_ERROR_STOP=1 -U $POSTGRES_USER <<-EOF
CREATE DATABASE roundcube;
EOF
