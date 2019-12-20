#!/bin/sh
set -eu

echo '🌱 plant DB seeds...' 
stack runghc src/App/Util/Seeds.hs
echo '👌 Done.'

