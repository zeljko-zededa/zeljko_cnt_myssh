#!/usr/bin/env bash
set -euo pipefail
printf 'ENV1 is: %s\n' "${1}"
printf 'ENV2 is: %s\n' "${2}"
printf 'ENV3 is: %s\n' "${2}"
/usr/sbin/sshd -D
