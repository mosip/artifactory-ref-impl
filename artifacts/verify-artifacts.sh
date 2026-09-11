#!/usr/bin/env bash
#
# Verifies every file served by the artifactory-server container is actually
# downloadable over HTTP, by downloading each one into a dedicated tmp
# directory and comparing size + sha256 against the file inside the
# container. Enumerates files from inside the running container (ground
# truth) instead of a hardcoded list, so it can't silently drift out of
# date as pom.xml / configure.sh change.
#
# Usage:
#   ./verify-artifacts.sh [container_name] [base_url]
#
#   ./verify-artifacts.sh                                   # defaults below
#   ./verify-artifacts.sh artifactory-test http://localhost:8080
#
# Optional: pass --start <image> to build/run the container for you, e.g.
#   ./verify-artifacts.sh --start artifactory-server-test:bookworm
#
# Downloaded files are written under a fresh directory named
# /tmp/artifactory-verify-<container>-<timestamp>/ (mirroring the served
# path structure) so results from different runs never collide, and nothing
# is silently overwritten. The directory is left in place on exit -- printed
# at the end -- so you can inspect downloaded artifacts afterward; delete it
# yourself when done.

set -euo pipefail

DOC_ROOT="/usr/share/nginx/html/artifactory"
CONTAINER_NAME="artifactory-test"
BASE_URL="http://localhost:8080"
STARTED_CONTAINER=0

if [ "${1:-}" = "--start" ]; then
  IMAGE="${2:?Usage: $0 --start <image>}"
  echo "Starting container '$CONTAINER_NAME' from image '$IMAGE'..."
  docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
  docker run -d --name "$CONTAINER_NAME" -p 8080:8080 "$IMAGE" >/dev/null
  STARTED_CONTAINER=1
  echo "Waiting for nginx to come up..."
  for _ in $(seq 1 30); do
    if curl -sf -o /dev/null "$BASE_URL/artifactory/"; then
      break
    fi
    sleep 1
  done
else
  CONTAINER_NAME="${1:-$CONTAINER_NAME}"
  BASE_URL="${2:-$BASE_URL}"
fi

cleanup_container() {
  if [ "$STARTED_CONTAINER" -eq 1 ]; then
    echo "Stopping container '$CONTAINER_NAME'..."
    docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
  fi
}
trap cleanup_container EXIT

if ! docker inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  echo "Container '$CONTAINER_NAME' not found. Start it first, e.g.:" >&2
  echo "  docker run -d --name $CONTAINER_NAME -p 8080:8080 artifactory-server-test:bookworm" >&2
  echo "or run this script with: $0 --start <image>" >&2
  exit 1
fi

TMP_DIR="/tmp/artifactory-verify-${CONTAINER_NAME}-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$TMP_DIR"
echo "Downloads will be saved under: $TMP_DIR"

echo "Enumerating served files inside container '$CONTAINER_NAME'..."
mapfile -t FILES < <(docker exec "$CONTAINER_NAME" find "$DOC_ROOT" -type f | sort)

total=${#FILES[@]}
if [ "$total" -eq 0 ]; then
  echo "No files found under $DOC_ROOT — something is very wrong." >&2
  exit 1
fi

echo "Found $total files. Downloading each to $TMP_DIR and verifying size + sha256 via $BASE_URL ..."
echo ""

fail=0
pass=0
FAILURES=()
bytes_total=0

for f in "${FILES[@]}"; do
  rel="${f#$DOC_ROOT}"
  url="${BASE_URL}/artifactory${rel}"
  dest="${TMP_DIR}${rel}"

  mkdir -p "$(dirname "$dest")"

  expected_size="$(docker exec "$CONTAINER_NAME" stat -c%s "$f")"
  expected_sha="$(docker exec "$CONTAINER_NAME" sha256sum "$f" | awk '{print $1}')"

  http_code="$(curl -sS -o "$dest" -w '%{http_code}' "$url" || echo "000")"

  if [ "$http_code" != "200" ] || [ ! -f "$dest" ]; then
    fail=$((fail + 1))
    FAILURES+=("$rel  -> HTTP $http_code (download failed)")
    continue
  fi

  actual_size="$(stat -c%s "$dest" 2>/dev/null || stat -f%z "$dest")"
  actual_sha="$(sha256sum "$dest" | awk '{print $1}')"

  if [ "$actual_size" != "$expected_size" ]; then
    fail=$((fail + 1))
    FAILURES+=("$rel  -> size mismatch (expected $expected_size, got $actual_size)")
  elif [ "$actual_sha" != "$expected_sha" ]; then
    fail=$((fail + 1))
    FAILURES+=("$rel  -> sha256 mismatch")
  else
    pass=$((pass + 1))
    bytes_total=$((bytes_total + actual_size))
    printf '.'
  fi
done
echo ""

echo ""
echo "==================== SUMMARY ===================="
echo "Total files checked : $total"
echo "Passed               : $pass"
echo "Failed               : $fail"
echo "Bytes downloaded     : $bytes_total"
echo "Download directory   : $TMP_DIR"

if [ "$fail" -gt 0 ]; then
  echo ""
  echo "Failing paths:"
  printf '  %s\n' "${FAILURES[@]}"
  exit 1
fi

echo ""
echo "All $total artifacts downloaded successfully and verified byte-for-byte — none missing."
