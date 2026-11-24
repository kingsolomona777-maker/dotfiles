#!/usr/bin/env bash
set -Eeuo pipefail

log() { printf '[dotfiles] %s\n' "$*"; }
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CONFIG="$DOTFILES_DIR/.config/opencode/opencode.json"
TARGET_DIR="$HOME/.config/opencode"
TARGET_CONFIG="$TARGET_DIR/opencode.json"

mkdir -p "$TARGET_DIR"
if [ -f "$SOURCE_CONFIG" ]; then
  ln -sfn "$SOURCE_CONFIG" "$TARGET_CONFIG"
  log "Linked global OpenCode config."
else
  log "OpenCode config not found at $SOURCE_CONFIG; leaving existing config untouched."
fi

if ! command -v curl >/dev/null 2>&1; then
  log "curl is required to install OpenCode; skipping installation."
  exit 0
fi

if command -v opencode >/dev/null 2>&1; then
  log "OpenCode is already installed: $(command -v opencode)"
else
  log "Installing OpenCode using the official installer..."
  curl -fsSL https://opencode.ai/v2/install | bash
fi

if command -v opencode >/dev/null 2>&1; then
  log "OpenCode is ready: $(opencode --version 2>/dev/null || printf 'version unavailable')"
else
  log "Installer finished, but OpenCode is not on this shell's PATH yet."
  log "Open a new terminal and run: opencode --version"
fi

if [ -z "${OPENROUTER_API_KEY:-}" ]; then
  log "OPENROUTER_API_KEY is not present in this Codespace."
  log "Add it as a GitHub Codespaces secret; never put the key in this repository."
else
  log "OPENROUTER_API_KEY is available (value not displayed)."
fi
