#!/usr/bin/env bash
set -euo pipefail
varoutputfile=$WORKDIR/zededa_environment_variables.txt
printf 'ENV1 is: %s\n' "${1}" | tee zededa_environment_variables.txt
printf 'ENV2 is: %s\n' "${2}" | tee >> zededa_environment_variables.txt
printf 'ENV3 is: %s\n' "${2}" | tee >> zededa_environment_variables.txt
/usr/sbin/sshd -D
