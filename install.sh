#!/usr/bin/env bash
# Installs Cyberpunk Capri into T3 Code's themes folder.
set -euo pipefail

REPO="jianwei0510/t3-theme-cyberpunk-capri"
RELEASE_TAG="assets-v1"
ANIMATED_ID="cyberpunk-capri-animated"
PLAIN_ID="cyberpunk-capri"
THEMES_DIR="${T3_THEMES_DIR:-$HOME/.t3/userdata/themes}"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE=""
NO_IMAGE=0
FORCE=0

usage() {
  cat <<EOF
Usage: ./install.sh [--image PATH] [--no-image] [--force]

  (default)     Install Cyberpunk Capri Animated with its background
  --image PATH  Install the animated theme with your own JPEG, PNG, or WebP
  --no-image    Install Cyberpunk Capri, colors only, dark and light
  --force       Replace an existing install

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

THEME_ID="$ANIMATED_ID"
[ "$NO_IMAGE" -eq 1 ] && THEME_ID="$PLAIN_ID"

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

download_background() {
  local asset="$ANIMATED_ID.webp"
  if command -v gh >/dev/null && gh release download "$RELEASE_TAG" --repo "$REPO" \
    --pattern "$asset" --output "$WORK/background" 2>/dev/null; then
    return 0
  fi
  command -v curl >/dev/null &&
    curl -fsSL "https://github.com/$REPO/releases/download/$RELEASE_TAG/$asset" -o "$WORK/background"
}

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
  download_background || {
    echo "Could not download the background. Use --image PATH or --no-image." >&2
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
echo "Open T3 Code, then choose it in Settings > Themes."
