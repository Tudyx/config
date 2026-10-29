#!/usr/bin/env bash

# Install the latest rust-analyzer release in ~/.local/bin.
# The rustup component is tied to the toolchain, so it lags behind the weekly releases.

set -o errexit
set -o pipefail
set -o nounset

BIN=~/.local/bin/rust-analyzer
URL="https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-$(uname -m)-unknown-linux-gnu.gz"

if command -v rust-analyzer &> /dev/null
then
  echo "Rust analyzer version before the update"
  rust-analyzer --version
else
  echo "No previous version of rust-analyzer found"
fi

# Download next to the binary so the final mv is atomic, and a failed
# download leaves the current version untouched.
mkdir -p "$(dirname "$BIN")"
TMP=$(mktemp "$BIN.XXXXXX")
trap 'rm -f "$TMP"' EXIT
curl --fail --location --silent --show-error "$URL" | gunzip -c - > "$TMP"
chmod +x "$TMP"
mv "$TMP" "$BIN"

echo "Rust analyzer version after the update"
"$BIN" --version
