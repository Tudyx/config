#!/usr/bin/env bash

# Script that force the focus to the workspace when switching.
# Useful when using multiple monitors. A patch exist but require a very recent version
# of gnome shell.

set -o errexit
set -o pipefail
set -o nounset

# Take the workspace number as parameter but wmctrl work with the workspace number minus 1.
WORKSPACE=$(($1 - 1))
WINDOW=$(wmctrl -l | awk -v workspace="$WORKSPACE" '$2 == workspace {print $1}' | tail -n 1)

# If there is no window inside the workspace.
if [[ -z "$WINDOW" ]]; then
  wmctrl -s $WORKSPACE
else
  wmctrl -i -a $WINDOW 
fi
