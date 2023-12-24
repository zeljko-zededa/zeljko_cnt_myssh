#!/usr/bin/env bash
set -euo pipefail
varoutputfile=$WORKDIR/zededa_environment_variables.txt
printf 'ENV1 is: %s\n' "${1}" | tee $varoutputfile
printf 'ENV2 is: %s\n' "${2}" | tee -a $varoutputfile
printf 'ENV3 is: %s\n' "${2}" | tee -a $varoutputfile
/usr/sbin/sshd -D
