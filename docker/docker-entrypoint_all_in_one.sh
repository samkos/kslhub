#!/bin/bash
set -e

echo "---> Starting the Slurm Node Daemon (slurmd) ..."
exec /usr/sbin/slurmd


exec "$@"
