# Install dotfiles

This use [GNU Stow] to manage dotfiles.

```sh
stow . --target=$HOME
```

[GNU Stow]: https://www.gnu.org/software/stow/


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
