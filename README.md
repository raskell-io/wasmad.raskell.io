# wasmad.raskell.io

Website for [WASM-AD](https://github.com/raskell-io/wasm-ad), a fantasy console with
Game Boy Advance–style hardware whose cartridges are WebAssembly modules. The site runs
the console live on the home page and hosts the standalone player at `/play/`.

**Live:** https://wasmad.raskell.io

## Quick start

```bash
mise run serve        # build, then http://127.0.0.1:8644
mise run preview      # build, then serve like Cloudflare Pages does
```

The build needs Rust with the `wasm32-unknown-unknown` target. It takes the player,
the carts and `SPEC.md` from [wasm-ad](https://github.com/raskell-io/wasm-ad) and the
Rainbow River cart from [rainbow-river](https://github.com/raskell-io/rainbow-river):
from sibling checkouts (`../wasm-ad`, `../rainbow-river`) when present, else from a
fresh clone of `main`. `WASM_AD=… RAINBOW_RIVER=… scripts/build.sh` points it elsewhere.

## Layout

| Path | |
|------|-|
| `site/` | The static pages, styles, script and art |
| `scripts/build.sh` | Builds the site into `dist/` |
| `scripts/cf-pages-build.sh` | Cloudflare Pages build command (output directory `dist`) |

## Deployment

Cloudflare Pages builds `main` with `scripts/cf-pages-build.sh` and serves `dist/`.

## License

MIT. Pixel art made with [PixelLab](https://www.pixellab.ai). WASM-AD is not affiliated with Nintendo.
