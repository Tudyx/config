#!/usr/bin/env bash

# Open the current selection or the clipboard in a firefox situated in
# workspace 2.

SELECTION=$(xsel --primary --output)
wmctrl -s 1

if [[ $SELECTION == https://* ]] || [[ $SELECTION == http://* ]] ;
then
  firefox --new-tab "$SELECTION"
else
  firefox --new-tab "https://duckduckgo.com/?t=ffab&q=$SELECTION"
fi

