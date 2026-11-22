#!/usr/bin/env bash
# Installs Cyberpunk Capri into T3 Code's themes folder.
set -euo pipefail

REPO="jianwei0510/t3-theme-cyberpunk-capri"
RELEASE_TAG="assets-v1"
ANIMATED_ID="cyberpunk-capri-animated"
LIGHT_ID="cyberpunk-capri-animated-light"
PLAIN_ID="cyberpunk-capri"
MAX_IMAGE_BYTES=$((16 * 1024 * 1024))
MAX_THEMES=32

T3_HOME="${T3CODE_HOME:-$HOME/.t3}"
case "$T3_HOME" in
  "~") T3_HOME="$HOME" ;;
  "~/"*) T3_HOME="$HOME/${T3_HOME#\~/}" ;;
esac
THEMES_DIR="${T3_THEMES_DIR:-$T3_HOME/userdata/themes}"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE=""
NO_IMAGE=0
LIGHT=0
FORCE=0

usage() {
  cat <<EOF
Usage: ./install.sh [--light] [--image PATH] [--no-image] [--force]

  (default)     Install Cyberpunk Capri Animated with its background
  --light       Install Cyberpunk Capri Animated Light with its background
  --image PATH  Use your own JPEG, PNG, or WebP background, up to 16 MB
  --no-image    Install Cyberpunk Capri, colors only, dark and light
  --force       Replace an existing install

Installs to $THEMES_DIR
Set T3_THEMES_DIR to use a different folder.
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --image) [ $# -ge 2 ] || { usage >&2; exit 2; }; IMAGE="$2"; shift 2 ;;
    --no-image) NO_IMAGE=1; shift ;;
    --light) LIGHT=1; shift ;;
    --force) FORCE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

if [ -n "$IMAGE" ] && [ "$NO_IMAGE" -eq 1 ]; then
  echo "Use either --image or --no-image, not both." >&2
  exit 2
fi

if [ "$LIGHT" -eq 1 ] && [ "$NO_IMAGE" -eq 1 ]; then
  echo "--no-image already includes light colors. Use it without --light." >&2
  exit 2
fi

THEME_ID="$ANIMATED_ID"
THEME_NAME="Cyberpunk Capri Animated"
MODE_HINT="Set the appearance mode to Dark. This theme only applies in Dark mode."
if [ "$LIGHT" -eq 1 ]; then
  THEME_ID="$LIGHT_ID"
  THEME_NAME="Cyberpunk Capri Animated Light"
  MODE_HINT="Set the appearance mode to Light. This theme only applies in Light mode."
fi
if [ "$NO_IMAGE" -eq 1 ]; then
  THEME_ID="$PLAIN_ID"
  THEME_NAME="Cyberpunk Capri"
  MODE_HINT="This theme works in both Light and Dark mode."
fi

SOURCE_JSON="$SOURCE_DIR/theme/$THEME_ID.json"
[ -f "$SOURCE_JSON" ] || { echo "Theme file not found: $SOURCE_JSON" >&2; exit 1; }

if [ "$FORCE" -eq 0 ]; then
  for existing in "$THEMES_DIR/$THEME_ID".{json,webp,png,jpg}; do
    if [ -e "$existing" ]; then
      echo "Already installed: $existing (use --force to replace it)" >&2
      exit 1
    fi
  done
fi

WORK="$(mktemp -d)"
STAGED_IMAGE=""
STAGED_JSON=""
cleanup() {
  rm -rf "$WORK"
  if [ -n "$STAGED_IMAGE" ]; then rm -f "$STAGED_IMAGE"; fi
  if [ -n "$STAGED_JSON" ]; then rm -f "$STAGED_JSON"; fi
}
trap cleanup EXIT
IMAGE_EXT=""

download_background() {
  local asset="$THEME_ID.webp"
  if command -v gh >/dev/null && gh release download "$RELEASE_TAG" --repo "$REPO" \
    --pattern "$asset" --output "$WORK/background" 2>/dev/null; then
    return 0
  fi
  command -v curl >/dev/null &&
    curl -fsSL "https://github.com/$REPO/releases/download/$RELEASE_TAG/$asset" -o "$WORK/background"
}

# Checks the file's real format, because T3 Code serves it by extension.
check_image() {
  local file="$1" ext="$2" size header
  size="$(wc -c < "$file" | tr -d ' ')"
  if [ "$size" -eq 0 ] || [ "$size" -gt "$MAX_IMAGE_BYTES" ]; then
    echo "Background must be between 1 byte and 16 MB." >&2
    return 1
  fi
  header="$(od -An -tx1 -N12 "$file" | tr -d ' \n')"
  case "$ext" in
    webp) [ "${header:0:8}" = "52494646" ] && [ "${header:16:8}" = "57454250" ] ;;
    png) [ "${header:0:8}" = "89504e47" ] ;;
    jpg) [ "${header:0:6}" = "ffd8ff" ] ;;
    *) false ;;
  esac || {
    echo "The background is not a valid .$ext image." >&2
    return 1
  }
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
  check_image "$WORK/background" "$IMAGE_EXT" || exit 1
elif [ "$NO_IMAGE" -eq 0 ]; then
  download_background || {
    echo "Could not download the background. Check your connection, or use --image PATH or --no-image." >&2
    exit 1
  }
  IMAGE_EXT="webp"
  check_image "$WORK/background" "$IMAGE_EXT" || exit 1
fi

# Stage inside the themes folder so each final move is atomic.
mkdir -p "$THEMES_DIR"
STAGED_JSON="$THEMES_DIR/.$THEME_ID.$$.json.tmp"
cp "$SOURCE_JSON" "$STAGED_JSON"
if [ -n "$IMAGE_EXT" ]; then
  STAGED_IMAGE="$THEMES_DIR/.$THEME_ID.$$.image.tmp"
  cp "$WORK/background" "$STAGED_IMAGE"
fi

for old_ext in webp png jpg; do
  if [ "$old_ext" != "$IMAGE_EXT" ]; then rm -f "$THEMES_DIR/$THEME_ID.$old_ext"; fi
done
if [ -n "$IMAGE_EXT" ]; then
  mv -f "$STAGED_IMAGE" "$THEMES_DIR/$THEME_ID.$IMAGE_EXT"
  STAGED_IMAGE=""
fi
mv -f "$STAGED_JSON" "$THEMES_DIR/$THEME_ID.json"
STAGED_JSON=""

echo "Installed $THEME_NAME to $THEMES_DIR"
THEME_COUNT="$(find "$THEMES_DIR" -maxdepth 1 -type f -name '*.json' | wc -l | tr -d ' ')"
if [ "$THEME_COUNT" -gt "$MAX_THEMES" ]; then
  echo "Warning: this folder has $THEME_COUNT themes, and T3 Code only loads $MAX_THEMES. Remove some if this one is not listed." >&2
fi
echo
echo "Next steps:"
echo "  1. Open Settings > Themes in T3 Code."
echo "  2. $MODE_HINT"
echo "  3. Choose $THEME_NAME."
