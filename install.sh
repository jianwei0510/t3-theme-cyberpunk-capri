#!/usr/bin/env bash
# Installs the Capri Night Sky theme into T3 Code's themes folder.
set -euo pipefail

THEME_ID="capri-night-sky"
REPO="jianwei0510/t3-theme-capri"
RELEASE_TAG="assets-v1"
THEMES_DIR="${T3_THEMES_DIR:-$HOME/.t3/userdata/themes}"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE=""
NO_IMAGE=0
FORCE=0

usage() {
  cat <<EOF
Usage: ./install.sh [--image PATH] [--no-image] [--force]

  --image PATH  Use a local JPEG, PNG, or WebP background
  --no-image    Install colors and gradient only
  --force       Replace an existing $THEME_ID install

Without --image or --no-image, the background is downloaded from the
$RELEASE_TAG release of $REPO using the GitHub CLI.
Set T3_THEMES_DIR to install somewhere other than $THEMES_DIR.
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --image) [ $# -ge 2 ] || { usage >&2; exit 2; }; IMAGE="$2"; shift 2 ;;
    --no-image) NO_IMAGE=1; shift ;;
    --force) FORCE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

if [ -n "$IMAGE" ] && [ "$NO_IMAGE" -eq 1 ]; then
  echo "Use either --image or --no-image, not both." >&2
  exit 2
fi

if [ "$FORCE" -eq 0 ]; then
  for existing in "$THEMES_DIR/$THEME_ID".{json,webp,png,jpg}; do
    if [ -e "$existing" ]; then
      echo "Already installed: $existing (use --force to replace it)" >&2
      exit 1
    fi
  done
fi

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
IMAGE_EXT=""

if [ -n "$IMAGE" ]; then
  [ -f "$IMAGE" ] || { echo "Image not found: $IMAGE" >&2; exit 1; }
  IMAGE_EXT="$(printf '%s' "${IMAGE##*.}" | tr '[:upper:]' '[:lower:]')"
  [ "$IMAGE_EXT" = "jpeg" ] && IMAGE_EXT="jpg"
  case "$IMAGE_EXT" in
    webp|png|jpg) ;;
    *) echo "Background must be JPEG, PNG, or WebP." >&2; exit 1 ;;
  esac
  cp "$IMAGE" "$WORK/background"
elif [ "$NO_IMAGE" -eq 0 ]; then
  command -v gh >/dev/null || {
    echo "GitHub CLI not found. Install gh, or use --image PATH or --no-image." >&2
    exit 1
  }
  gh release download "$RELEASE_TAG" --repo "$REPO" --pattern "$THEME_ID.webp" \
    --output "$WORK/background" || {
    echo "Could not download the background. Check repo access, or use --image PATH or --no-image." >&2
    exit 1
  }
  IMAGE_EXT="webp"
fi

mkdir -p "$THEMES_DIR"
rm -f "$THEMES_DIR/$THEME_ID".{webp,png,jpg}
if [ -n "$IMAGE_EXT" ]; then
  cp "$WORK/background" "$THEMES_DIR/$THEME_ID.$IMAGE_EXT"
fi
cp "$SOURCE_DIR/theme/$THEME_ID.json" "$THEMES_DIR/$THEME_ID.json"

echo "Installed $THEME_ID to $THEMES_DIR"
echo "Open T3 Code, then choose Capri Night Sky in Settings > Themes."
