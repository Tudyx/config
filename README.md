# Install dotfiles

This use [GNU Stow] to manage dotfiles.

```sh
stow . --target=$HOME
```

[GNU Stow]: https://www.gnu.org/software/stow/

# Install GNOME settings

GNOME settings live in dconf, which stow can't manage. Apply them with:

```sh
scripts/gnome_setup.sh
```

# Keyboard shortcuts

Each modifier belongs to one layer, so shortcuts don't clash:

| Modifier                    | Owner                         | Examples                                               |
|-----------------------------|-------------------------------|--------------------------------------------------------|
| `Super`                     | GNOME (desktop)               | `Super+1..4` workspace, `Super+Shift+1..4` move window |
| `Alt+number`                | apps with tabs                | go to tab N in Ghostty and Firefox                     |
| `Ctrl+Shift`, `Ctrl+Alt`    | the terminal (Ghostty)        | new tab, splits, copy/paste, move between splits       |
| `Ctrl`, `Alt+letter`        | programs inside the terminal  | fish, Helix                                            |

# Install xtool

```sh
cd xtool
cargo build --release
ln -s $PWD/target/release/xtool $HOME/.local/bin
```

# Install gg

```sh
cd gg
cargo build --release
ln -s $PWD/target/release/gg $HOME/.local/bin
```
