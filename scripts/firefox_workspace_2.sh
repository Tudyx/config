#!/usr/bin/env bash

# Open the current selection or the clipboard in a firefox situated in
# workspace 2.

SELECTION=$(xsel --primary --output)
wmctrl -s 1
# Sometimes the switch between the workspace is too slow and the tab launch
# inside the old workspace. Hence the delay.
sleep 0.2

if [[ $SELECTION == https://* ]] || [[ $SELECTION == http://* ]] ;
then
  firefox --new-tab "$SELECTION"
else
  firefox --new-tab "https://duckduckgo.com/?t=ffab&q=$SELECTION"
fi

