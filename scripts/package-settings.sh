#!/usr/bin/env bash
# Build an IntelliJ-importable settings zip from this repository.
#
# Usage:
#   ./scripts/package-settings.sh [output.zip]
#
# Default output: ~/Downloads/intellij-idea-settings-import.zip
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

OUT="${1:-${HOME}/Downloads/intellij-idea-settings-import.zip}"
MARKER="IntelliJ IDEA Global Settings"

DIRS=(keymaps colors codestyles templates inspection options quicklists)
FILES=(installed.txt)

log() { printf '%s\n' "$*"; }
die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

command -v zip >/dev/null 2>&1 || die "zip not found on PATH"
[[ -d "${REPO_ROOT}/options" ]] || die "not a settings repo: ${REPO_ROOT}"

for d in "${DIRS[@]}"; do
  [[ -d "${REPO_ROOT}/${d}" ]] || die "missing directory: ${d}"
done

mkdir -p -- "$(dirname -- "${OUT}")"
rm -f -- "${OUT}"
OUT="$(cd -- "$(dirname -- "${OUT}")" && pwd)/$(basename -- "${OUT}")"

TMP="$(mktemp -d)"
trap 'rm -rf -- "${TMP}"' EXIT
: > "${TMP}/${MARKER}"

(
  cd -- "${TMP}"
  zip -q "${OUT}" "${MARKER}"
)

(
  cd -- "${REPO_ROOT}"
  zip -qr "${OUT}" "${DIRS[@]}"
  for f in "${FILES[@]}"; do
    [[ -f "${f}" ]] && zip -q "${OUT}" "${f}"
  done
)

count="$(zipinfo -1 "${OUT}" | wc -l)"
size="$(wc -c < "${OUT}")"
log "files_in_zip=${count}"
log "size_bytes=${size}"
log "Created: ${OUT}"
log "Import: File → Manage IDE Settings → Import Settings… → ${OUT}"
