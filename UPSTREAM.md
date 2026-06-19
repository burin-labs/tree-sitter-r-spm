# Upstream provenance

This repo is a Swift Package Manager wrapper around an upstream tree-sitter
grammar. The grammar lives in another repo; we vendor its generated
`parser.c` (and any scanner) under `Sources/TreeSitterR/src/` so SPM can
build it without needing `tree-sitter-cli`.

## Upstream

- **Repo:** https://github.com/r-lib/tree-sitter-r
- **License:** see upstream `LICENSE`

## Vendored commit

| Field | Value |
| --- | --- |
| Last reviewed commit | `fb58721f78102b82f43120a058c6478f38bf47d3` |
| Provenance | re-vendored from upstream HEAD on 2026-06-19 |
| Latest upstream HEAD as of 2026-06-19 | `fb58721f78102b82f43120a058c6478f38bf47d3` |

When you re-vendor, update **Last reviewed commit** to the exact upstream SHA
whose `src/parser.c` you copied in, and bump the date.

## How to re-vendor

```sh
# in a scratch dir
git clone https://github.com/r-lib/tree-sitter-r
cd tree-sitter-r
UPSTREAM_SHA="$(git rev-parse HEAD)"

# Regenerate the parser if you're updating the grammar:
# npx tree-sitter generate

# Copy the artifact + headers into this repo:
cp src/parser.c        "$THIS_REPO/Sources/TreeSitterR/src/parser.c"
cp src/tree_sitter/*.h "$THIS_REPO/Sources/TreeSitterR/src/tree_sitter/" 2>/dev/null || true
# If the grammar ships a custom scanner, copy that too:
[ -f src/scanner.c ] && cp src/scanner.c "$THIS_REPO/Sources/TreeSitterR/src/scanner.c"

# Update this file with the new SHA.
sed -i '' "s|Last reviewed commit | \`.*\`|Last reviewed commit | \`${UPSTREAM_SHA}\`|" "$THIS_REPO/UPSTREAM.md"
```

Review the diff carefully -- a multi-hundred-KB `parser.c` is the supply
chain. If you can't justify each chunk, do not commit it.

## Why this matters

Without this file, reviewers of a re-vendor PR have no way to know which
upstream commit produced the changes. That's how supply-chain attacks land
unnoticed in generated artifacts.
