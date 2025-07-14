#!/usr/bin/env bash
# Usage:
#   ./rebuild.sh laptop

set -euo pipefail

logfile=rebuild.log

host=${1:-${DEFAULT_REBUILD_HOST:-}}

if [[ -z "$host" ]]; then
  echo "Usage: $0 <hostname>"
  echo "Or set DEFAULT_REBUILD_HOST environment variable."
  exit
fi
echo "Host target: $host"

# Autoformat
echo "Formatting .nix files..."
alejandra . || (echo "Formatting failed!" && exit 1)

# if git diff --quiet && git diff --cached --quiet; then
#   echo "No changes detected, exiting."
#   exit 0
# fi

# Show diff
echo "Diff:"
git diff -U0 '*.nix'
read -rp "Commit message (enter to skip): " usermsg
# Rebuild
echo "Building system using [${host}] config..."
start=$(date +%s)
if ! sudo nixos-rebuild switch --flake ".#${host}" &> "${logfile}"; then
  echo "Build failed. Showing errors:"
  cat "${logfile}" | rg error || cat "${logfile}"
  exit 1
fi

end=$(date +%s)
duration=$(( end - start ))
echo -e "\033[1;36m  Took ${duration}s\033[0m"

# Get generation info
current=$(nixos-rebuild list-generations | rg current || echo "generation-info-missing")

echo "Adding and committing all changes..."
git add .
if git diff --cached --quiet; then
  echo "Nothing to commit."
else
  git commit -m "$current${usermsg:+ - $usermsg}"
fi

echo "Rebuild using [${host}] config complete and committed."
