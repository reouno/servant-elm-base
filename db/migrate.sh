#!/bin/sh
set -eu

echo '🚂 Migrate schema...';
createdb seb-dev;
stack runghc src/App/Util/Migrate.hs;
echo '👌 Done.'
