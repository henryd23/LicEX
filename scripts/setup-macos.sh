#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo 'Homebrew is required. Install it from https://brew.sh/ and run this script again.' >&2
  exit 1
fi

brew update
brew install node llvm ninja cmake openssl@3

if ! command -v rustup >/dev/null 2>&1; then
  brew install rustup
  rustup-init -y
fi

source "$HOME/.cargo/env"
rustup default stable
npm install -g pnpm@10.17.1

node -e "const [major, minor] = process.versions.node.split('.').map(Number); if (major < 20 || (major === 20 && minor < 19)) process.exit(1)" || {
  echo 'Node.js 20.19.0 or newer is required.' >&2
  exit 1
}

cat <<'EOF'

Prerequisites installed. Run from the repository root:
  pnpm install --frozen-lockfile
  pnpm run tauri:dev

If Cargo cannot find OpenSSL or libclang, see the environment-variable section
in README.md. Homebrew prefixes are architecture-independent when obtained via
`brew --prefix`.
EOF
