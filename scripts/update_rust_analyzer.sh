#!/usr/bin/env bash
# WARNING this script bugs if rust-analyzer was installed before as a rustup component by cargo.
# In that case, please run this before `rm ~/.cargo/bin/rust-analyzer`

set -o errexit
set -o pipefail
set -o nounset

if command -v rust-analyzer &> /dev/null
then
  echo "Rust analyzer version before the update"
  rust-analyzer --version
else
  echo "No previous version of rust-analyzer found"
fi

curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer
chmod +x ~/.cargo/bin/rust-analyzer
echo "Rust analyzer version after the update"
rust-analyzer --version

