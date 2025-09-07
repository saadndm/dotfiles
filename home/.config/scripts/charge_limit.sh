#!/usr/bin/env bash
set -euo pipefail

SYSFILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

if [[ ! -e "$SYSFILE" ]]; then
  exit 1
fi

curr=$(<"$SYSFILE")

if [[ "$curr" == "0" ]]; then
  echo "1" | sudo tee "$SYSFILE" >/dev/null
else
  echo "0" | sudo tee "$SYSFILE" >/dev/null
fi
