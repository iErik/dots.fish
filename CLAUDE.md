# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Fish shell dotfiles repository distributed as a NixOS Home Manager module. The repo is cloned to a local directory and symlinked to `~/.config/fish` by the Home Manager activation script.

## Deployment

This repo has no build step or test suite. It is deployed via Home Manager:

- The Nix module lives in `nix/default.nix` and is exported from `flake.nix` as `homeManagerModules.dots.fish`
- Enable in a Home Manager config: `config.dots.fish.enable = true`
- On activation, the module clones this repo (default: `~/Dots/Fish.dots`) and symlinks it to `~/.config/fish`

Module options (all optional):
- `cloneConfig` (bool, default: true) — whether to clone/update the repo
- `directory` (string, default: `~/Dots/Fish.dots`) — where to clone
- `branch` (string, default: `master`) — which branch to track

## Architecture

Fish loads configuration in a defined order at shell startup:

1. **`conf.d/`** — sourced first, automatically, in alphabetical order
   - `omf.fish` — bootstraps Oh My Fish framework
   - `fish_frozen_theme.fish` — sets theme color variables
   - `fish_frozen_key_bindings.fish` — configures vi-mode key bindings
   - `rustup.fish` — initializes the Rust toolchain environment

2. **`config.fish`** — main config, sourced after `conf.d/`
   - Extends `$PATH` (Cargo, local bins, Spicetify, etc.)
   - Sets environment variables (`EDITOR`, FZF options, Vagrant, npm token)
   - Defines aliases and abbreviations
   - Initializes FNM (Node version manager) and Bun

3. **`functions/`** — autoloaded by Fish on first call
   - `fish_command_not_found.fish` — extends the default handler with Distrobox container support

4. **`completions/`** — autoloaded when tab-completing a command
   - `bun.fish` — dynamic completions for Bun, including per-project script detection

5. **`fish_variables`** — Fish's universal variable store (auto-managed by Fish; avoid hand-editing)
