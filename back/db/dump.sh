#!/bin/sh
set -eu

echo '🖨 Dump DB schema...'
pg_dump seb-dev > db/seb-dev.sql
echo '👌 Done.'
