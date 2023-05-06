#/bin/bash

cd "$(dirname "$0")"

TARGET_NAME=script.sh
INSTALL_NAME=/usr/bin/backup

cp "$TARGET_NAME" "$INSTALL_NAME"

echo "$TARGET_NAME has been copied to the $INSTALL_NAME"
