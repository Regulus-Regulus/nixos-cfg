#!/usr/bin/env bash
# Usage:
#   ./remote.sh laptop user@target

set -euo pipefail

logfile=~/NixosConfiguration/.remote.log
flake_path="$HOME/NixosConfiguration"

host=$1
target=$2
if [[ -z "$host" ]]; then
  echo "Usage: $0 <hostname>"
  exit
fi
echo "Host target: $host"
if [[ -z "$target" ]]; then
  echo "Usage: $0 <user@target>"
  exit
fi
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
if ! nixos-rebuild --flake "${flake_path}#${host}" --sudo --ask-sudo-password --build-host "${target}" --target-host "${target}" switch  &> "${logfile}"; then
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
