# Codespaces dotfiles

Account-level GitHub Codespaces personalization for this account.

## What this installs

- OpenCode CLI (current v2 installer) in every **new** Codespace that uses this dotfiles repository.
- A global OpenCode configuration linked to `~/.config/opencode/opencode.json`.
- OpenRouter as the model provider, using the `OPENROUTER_API_KEY` environment variable.

## Required secret

Create a **Codespaces** secret named `OPENROUTER_API_KEY` in GitHub Settings → Secrets and variables → Codespaces. Give it access to the repositories where you want OpenCode to use OpenRouter, including `ai-command-centre`.

The key is never stored in this repository. Do not paste it into a config file, commit, issue, or chat.

## Installation

GitHub Codespaces runs `install.sh` when a new Codespace is created. The script links the global config and is safe to rerun. Existing Codespaces do not automatically receive dotfiles changes; rerun `install.sh` from the dotfiles checkout or create a new Codespace.

## Default model

The global config selects `openrouter/recursive/flint-v1.0:free`. You can change the model in `~/.config/opencode/opencode.json` or override it per project with a project-level `opencode.json`.
