#!/usr/bin/env bash

# This was taken and modified from https://github.com/uelel/kdeconnect-mount

ANDROID_USER="kdeconnect"
ANDROID_DIR="/storage/emulated/0"
SSH_KEY="$HOME/.config/kdeconnect/privateKey.pem"

# Function to show usage
usage() {
  echo "Usage: $0 (-d <device_id> | -n <device_name>) <mount_path>"
  exit 1
}

# Check if required utilities are installed
for cmd in kdeconnect-cli dbus-send sshfs ss mountpoint; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: Required utility '$cmd' is not installed or not available in PATH." >&2
    exit 1
  fi
done

# Parse command-line arguments
DEVICE_ID=""
DEVICE_NAME=""
DEVICE_HOST=""
MOUNT_PATH=""
if [[ "$#" -lt 2 ]]; then
  usage
fi
while [[ "$#" -gt 0 ]]; do
  case "$1" in
  -d | --device)
    DEVICE_ID="$2"
    shift 2
    ;;
  -n | --name)
    DEVICE_NAME="$2"
    shift 2
    ;;
  *)
    if [ -z "$MOUNT_PATH" ]; then
      MOUNT_PATH="$1"
      shift
    else
      usage
    fi
    ;;
  esac
done

# Ensure either device ID or device name is provided
# Ensure mount path is provided
if [ -z "$DEVICE_ID" ] && [ -z "$DEVICE_NAME" ]; then
  echo "Error: Either -d <device_id> or -n <device_name> must be provided." >&2
  usage
fi
if [ -z "$MOUNT_PATH" ]; then
  echo "Error: Mount path is required." >&2
  usage
fi

echo "Looking up KDE Connect device..."
DEVICE_LIST=$(kdeconnect-cli -l)
echo "$DEVICE_LIST"

while IFS= read -r line; do
  if [[ "$line" =~ ^-[[:space:]]([^:]+):[[:space:]]([a-f0-9]+)[[:space:]]on[[:space:]]([^[:space:]]+) ]]; then
    extracted_name="${BASH_REMATCH[1]}"
    extracted_id="${BASH_REMATCH[2]}"
    extracted_host="${BASH_REMATCH[3]}"

    if { [ -n "$DEVICE_NAME" ] && [ "$extracted_name" = "$DEVICE_NAME" ]; } || { [ -n "$DEVICE_ID" ] && [ "$extracted_id" = "$DEVICE_ID" ]; }; then
      DEVICE_ID="$extracted_id"
      DEVICE_HOST="$extracted_host"
      break
    fi
  fi
done <<<"$DEVICE_LIST"

if [ -z "$DEVICE_ID" ] || [ -z "$DEVICE_HOST" ]; then
  echo "Error: Could not resolve device. Ensure it is paired and reachable." >&2
  exit 1
fi

echo "Resolved device to ID: $DEVICE_ID, host: $DEVICE_HOST"

if mountpoint -q "$MOUNT_PATH"; then
  echo "Already mounted at $MOUNT_PATH"
  exit 0
fi

if ! dbus-send --session --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames 2>/dev/null | grep -q org.kde.kdeconnect; then
  echo "Error: kdeconnect service is not running or not available." >&2
  exit 1
fi

# Activate SFTP service for the given device ID
echo "Activating SFTP service for device ID: $DEVICE_ID"
if ! dbus-send --session --dest=org.kde.kdeconnect --type=method_call --print-reply "/modules/kdeconnect/devices/$DEVICE_ID/sftp" org.kde.kdeconnect.device.sftp.mountAndWait >/dev/null; then
  echo "Error: Failed to activate SFTP service for device $DEVICE_ID." >&2
  exit 1
fi

ANDROID_PORT=$(ss -tnp | awk -v host="$DEVICE_HOST" '$5 ~ host && $0 ~ /ssh/ { split($5, a, ":"); print a[length(a)]; exit }')
if [ -z "$ANDROID_PORT" ]; then
  echo "Error: Could not detect SFTP port for $DEVICE_HOST." >&2
  exit 1
fi

if [ -L "$MOUNT_PATH" ]; then
  echo "Removing existing symlink at $MOUNT_PATH"
  if ! rm -f "$MOUNT_PATH" 2>/dev/null; then
    sudo rm -f "$MOUNT_PATH"
  fi
fi

if [ -e "$MOUNT_PATH" ] && [ ! -d "$MOUNT_PATH" ]; then
  echo "Error: $MOUNT_PATH exists and is not a directory." >&2
  exit 1
fi

if [ ! -d "$MOUNT_PATH" ]; then
  if mkdir -p "$MOUNT_PATH" 2>/dev/null; then
    :
  else
    echo "Creating $MOUNT_PATH requires sudo because $(dirname "$MOUNT_PATH") is not writable."
    sudo mkdir -p "$MOUNT_PATH"
    sudo chown "$(id -u):$(id -g)" "$MOUNT_PATH"
  fi
elif [ ! -w "$MOUNT_PATH" ]; then
  echo "Taking ownership of $MOUNT_PATH requires sudo."
  sudo chown "$(id -u):$(id -g)" "$MOUNT_PATH"
fi

echo "Mounting $ANDROID_USER@$DEVICE_HOST:$ANDROID_DIR at $MOUNT_PATH"
sshfs -o rw,nosuid,nodev,identityfile="$SSH_KEY",port="$ANDROID_PORT",uid=$(id -u),gid=$(id -g) "$ANDROID_USER@$DEVICE_HOST:$ANDROID_DIR" "$MOUNT_PATH"

# Check if the mount was successful
if ! mountpoint -q "$MOUNT_PATH"; then
  echo "Error: Failed to mount the Android filesystem at $MOUNT_PATH." >&2
  exit 1
fi

echo "Android device mounted successfully at $MOUNT_PATH."
