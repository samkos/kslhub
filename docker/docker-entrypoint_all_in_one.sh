#!/bin/bash
set -e

gosu munge /usr/sbin/munged \
    && echo "---> Starting the Slurm Controller Daemon (slurmctld) ..." \
    && exec gosu slurm /usr/sbin/slurmctld -Dvvv \
    && echo "---> Starting the Slurm Node Daemon (slurmd) ..." \
    && exec /usr/sbin/slurmd \
    && echo "---> Starting kslhub ..." \
    && cd /kslhub/INSTALL \
    && bash  Run_kslhub.sh 

