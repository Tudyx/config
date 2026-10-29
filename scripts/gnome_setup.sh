#!/usr/bin/env bash

# Apply the GNOME settings that stow can't manage (they live in dconf).
# Safe to run several times.

set -o errexit
set -o pipefail
set -o nounset

WM=org.gnome.desktop.wm.keybindings
SHELL_KEYS=org.gnome.shell.keybindings
MEDIA_KEYS=org.gnome.settings-daemon.plugins.media-keys

# 4 fixed workspaces, so Super+1..4 always has a target.
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4

# Free Ctrl+Alt+arrows for Ghostty split navigation.
gsettings set $WM switch-to-workspace-left "['<Super>Page_Up', '<Super>KP_Prior', '<Super><Alt>Left']"
gsettings set $WM switch-to-workspace-right "['<Super>Page_Down', '<Super>KP_Next', '<Super><Alt>Right']"
gsettings set $WM switch-to-workspace-up "[]"
gsettings set $WM switch-to-workspace-down "[]"

# Super+N switches to workspace N and Super+Shift+N moves the current window
# there, leaving Alt+N to apps (tabs). Super+N opens the Nth dock app by
# default, both in GNOME and in the Ubuntu Dock, so free it first.
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
for i in 1 2 3 4; do
  # Clear them too: the Ubuntu 22.04 dock may keep them despite hot-keys false.
  for key in app-hotkey app-shift-hotkey app-ctrl-hotkey; do
    gsettings set org.gnome.shell.extensions.dash-to-dock $key-$i "[]"
  done
  gsettings set $SHELL_KEYS switch-to-application-$i "[]"
  gsettings set $WM switch-to-workspace-$i "['<Super>$i']"
  gsettings set $WM move-to-workspace-$i "['<Super><Shift>$i']"
done

# No custom shortcuts.
dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
gsettings set $MEDIA_KEYS custom-keybindings "[]"
