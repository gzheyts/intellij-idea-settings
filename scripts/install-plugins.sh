#!/usr/bin/env bash
# Install IntelliJ plugins listed in installed.txt (repo root).
#
# Usage:
#   ./scripts/install-plugins.sh [installed.txt]
#
# Requires `idea` on PATH. Close IDEA before running.
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

LIST_FILE="${1:-${REPO_ROOT}/installed.txt}"

log() { printf '%s\n' "$*"; }
die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

command -v idea >/dev/null 2>&1 || die "idea not found on PATH"
[[ -f "${LIST_FILE}" ]] || die "plugin list not found: ${LIST_FILE}"

mapfile -t PLUGINS < <(
  sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' "${LIST_FILE}" \
    | grep -v '^$' || true
)

[[ "${#PLUGINS[@]}" -gt 0 ]] || die "no plugins in ${LIST_FILE}"

log "Installing ${#PLUGINS[@]} plugins from ${LIST_FILE}…"
set +e
idea installPlugins --give-consent-to-use-third-party-plugins "${PLUGINS[@]}"
rc=$?
set -e

if [[ "${rc}" -ne 0 ]]; then
  log "installPlugins exited with ${rc} (often means some ids were unknown)."
  log "Check output above for 'unknown plugins'."
  exit "${rc}"
fi

log "Done."
