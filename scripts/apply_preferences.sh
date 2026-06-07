#!/usr/bin/env bash
set -euo pipefail

PREFERENCEFILE="${1:-Preferencefile}"

if [[ ! -f "$PREFERENCEFILE" ]]; then
  echo "Error: $PREFERENCEFILE not found" >&2
  exit 1
fi

_restart_dock=false
_restart_finder=false

while IFS= read -r line; do
  [[ "$line" =~ ^[[:space:]]*(#|$) ]] && continue

  domain=$(grep -o '"[^"]*"' <<< "$line" | sed -n '1p' | tr -d '"')
  key=$(grep -o '"[^"]*"' <<< "$line" | sed -n '2p' | tr -d '"')
  value=$(grep -o '"[^"]*"' <<< "$line" | sed -n '3p' | tr -d '"')

  if [[ -z "$domain" || -z "$key" || -z "$value" ]]; then
    echo "Warning: skipping malformed line: $line" >&2
    continue
  fi

  echo "Applying: defaults write \"$domain\" \"$key\" $value"
  # shellcheck disable=SC2086
  defaults write "$domain" "$key" $value

  case "$domain" in
    *[Dd]ock*)   _restart_dock=true ;;
    *[Ff]inder*) _restart_finder=true ;;
  esac
done < "$PREFERENCEFILE"

$_restart_dock   && killall Dock   2>/dev/null || true
$_restart_finder && killall Finder 2>/dev/null || true

echo "Preferences applied."
