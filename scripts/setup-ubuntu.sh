#!/usr/bin/env bash
set -euo pipefail

if ! command -v apt-get >/dev/null 2>&1; then
  echo 'This script supports Ubuntu/Debian systems using apt-get.' >&2
  echo 'For another Linux distribution, install the equivalent packages listed in README.md.' >&2
  exit 1
fi

sudo apt-get update
sudo apt-get install -y \
  build-essential \
  curl \
  pkg-config \
  libssl-dev \
  libwebkit2gtk-4.1-dev \
  libappindicator3-dev \
  librsvg2-dev \
  patchelf \
  libglib2.0-dev \
  libgtk-3-dev \
  libdbus-1-dev \
  cmake \
  ninja-build \
  clang \
  git

if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source "$HOME/.cargo/env"
rustup default stable

if ! command -v node >/dev/null 2>&1; then
  echo 'Node.js >=20.19.0 is required. Install an LTS release from https://nodejs.org/ and run this script again.' >&2
  exit 1
fi

node -e "const [major, minor] = process.versions.node.split('.').map(Number); if (major < 20 || (major === 20 && minor < 19)) process.exit(1)" || {
  echo 'Node.js 20.19.0 or newer is required.' >&2
  exit 1
}

npm install -g pnpm@10.17.1

cat <<'EOF'

Prerequisites installed. Run from the repository root:
  pnpm install --frozen-lockfile
  pnpm run tauri:dev
EOF
