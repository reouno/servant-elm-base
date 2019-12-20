#!/bin/sh
set -eu

# TODO: Define variables as environment variable or
#       replace this script with haskell program
#       that rakes variables from setting yaml file.
echo '⏮  delete DB...';
dropdb --if-exists "seb-dev"
echo '👌 Done.'

