#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
bash -n PKGBUILD
python3 - <<'PY'
import hashlib, pathlib, re, zipfile
recipe = pathlib.Path('PKGBUILD').read_text()
for name in ('caelestia.patch', 'night-green.tdesktop-theme'):
    path = pathlib.Path('patches') / name
    digest = hashlib.sha512(path.read_bytes()).hexdigest()
    assert digest in recipe, f'Checksum mismatch for {path}'
for path in (pathlib.Path('night-green-original.tdesktop-theme'), pathlib.Path('patches/night-green.tdesktop-theme')):
    with zipfile.ZipFile(path) as archive:
        assert archive.testzip() is None, f'Invalid theme: {path}'
html = pathlib.Path('motion_studio/index.html').read_text()
for path in re.findall(r'''(?:src|href)=["'](gifs/[^"']+)["']''', html):
    assert (pathlib.Path('motion_studio') / path).is_file(), f'Missing asset: {path}'
print('Recipe syntax, local checksums, theme archives and motion assets: OK')
PY
if [[ ${1:-} == --upstream ]]; then
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  curl -fsSL --retry 3 -o "$tmp/source.tar.gz" https://github.com/telegramdesktop/tdesktop/releases/download/v7.3.3/tdesktop-7.3.3-full.tar.gz
  echo '3e76971f5ac1c8b4f29c867cf2a6e52f5eb71e479533daaaef26ba8bf53c10c6dd0abc09bb99ec213582546a50fa5306b2bcad023e85024979ebf04603c48540  '"$tmp/source.tar.gz" | sha512sum -c -
  tar -xzf "$tmp/source.tar.gz" -C "$tmp"
  patch --dry-run --batch -s -p1 -d "$tmp/tdesktop-7.3.3-full" < patches/caelestia.patch
  echo 'Patch applies to verified upstream source: OK'
fi
