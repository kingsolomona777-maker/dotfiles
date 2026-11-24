#!/usr/bin/env bash
set -Eeuo pipefail

log() { printf '[dotfiles] %s\n' "$*"; }

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
