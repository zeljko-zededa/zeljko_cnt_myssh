#!/usr/bin/env bash
set -euo pipefail
my_outfile=zededa-environment-variables.txt
echo "${1}" >> $my_outfile
echo "${2}" >> $my_outfile
echo "${3}" >> $my_outfile
/usr/sbin/sshd -D
