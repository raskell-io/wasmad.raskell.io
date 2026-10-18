#!/usr/bin/env bash
# Build the website into OUT_DIR: site/ plus the web player, the carts and the
# spec from wasm-ad, and the Rainbow River cart.
#
#   scripts/build.sh [OUT_DIR]        # default: dist
#
# WASM_AD and RAINBOW_RIVER point at local checkouts; when unset, the sibling
# directories are used if present, otherwise main of each repo is cloned.
set -euo pipefail
OUT="${1:-dist}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

checkout() { # name -> path of a checkout
    local dir="../$1"
    if [ -d "$dir" ]; then echo "$dir"; return; fi
    git clone -q --depth 1 "https://github.com/raskell-io/$1.git" "$TMP/$1"
    echo "$TMP/$1"
}
WASM_AD="${WASM_AD:-$(checkout wasm-ad)}"
RAINBOW_RIVER="${RAINBOW_RIVER:-$(checkout rainbow-river)}"
echo "wasm-ad: $WASM_AD"
echo "rainbow-river: $RAINBOW_RIVER"

make -C "$WASM_AD" all
make -C "$RAINBOW_RIVER" build

rm -rf "$OUT"
mkdir -p "$OUT/play" "$OUT/carts"
cp -R site/. "$OUT/"
web="$WASM_AD/player/web"
cp "$web/index.html" "$web/player.js" "$web/wasm-ad.js" "$web/core.wasm" "$OUT/play/"
cp "$web"/carts/*.wasm "$RAINBOW_RIVER/web/carts/rainbow-river.wasm" "$OUT/carts/"
cp "$WASM_AD/SPEC.md" "$OUT/"
echo "Site in $OUT"
