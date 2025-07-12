#!/usr/bin/env bash
# Usage:
#   ./rebuild.sh laptop

set -euo pipefail

logfile=rebuild.log
host=$1

if [[ -z "$host" ]]; then
  echo "Usage: $0 <hostname>"
  exit 1
fi

echo "Host target: $host"

# Autoformat
echo "🧼 Formatting .nix files..."
alejandra . || (echo "❌ Formatting failed!" && exit 1)

# Skip build if no changes
if git diff --quiet '*.nix'; then
  echo "✅ No changes in tracked .nix files. Exiting."
  exit 0
fi

# Show diff
echo "📄 Diff:"
git diff -U0 '*.nix'

# Rebuild
echo "🏗️ Building system for ${host}..."
if ! sudo nixos-rebuild switch --flake ".#${host}" &> "${logfile}"; then
  echo "❌ Build failed. Showing errors:"
  cat "${logfile}" | rg error || cat "${logfile}"
  exit 1
fi

# Get generation info
current=$(nixos-rebuild list-generations | rg current || echo "generation-info-missing")

echo "📦 Adding and committing all changes..."
git add .
git commit -m "$current"

echo "Rebuild for $host complete and committed."
