# homebrew-tap

Homebrew formulae for [ildarbinanas-design](https://github.com/ildarbinanas-design) projects.

## Install

```sh
brew install ildarbinanas-design/tap/env-vault
brew install ildarbinanas-design/tap/macos-user-settings
```

Or tap first, then install:

```sh
brew tap ildarbinanas-design/tap
brew install env-vault
brew install macos-user-settings
```

`env-vault` supports macOS 15 Sequoia or newer (Apple Silicon and Intel) and
Linux (arm64 and amd64). `macos-user-settings` supports macOS 15 Sequoia or
newer on Apple Silicon and Intel.

No `xattr -d com.apple.quarantine` needed — Homebrew downloads do not get the
Gatekeeper quarantine attribute.

## Upgrade

```sh
brew upgrade env-vault
brew upgrade macos-user-settings
```

## Formulae

| Formula | Description |
| --- | --- |
| [env-vault](Formula/env-vault.rb) | Secure environment variable vault for running commands with profiles |
| [macos-user-settings](Formula/macos-user-settings.rb) | Manage selected macOS user preferences from a strict YAML profile |

Each formula is pinned to immutable artifacts from the corresponding tagged
project release: [env-vault](https://github.com/ildarbinanas-design/env-vault)
and [macos-user-settings](https://github.com/ildarbinanas-design/macos-user-settings).

## Formula verification

CI compares each complete formula, byte for byte, with its template in
`.github/workflows/formula-check/templates/`. It fills only the version and the checksums from
that project's published release sidecars. The checker never evaluates Ruby
to decide whether a formula is trusted. Homebrew style, strict audit, install,
and test still run on both supported macOS architectures.

The checker and templates stay in the reserved workflow directory, so changes
to what CI accepts follow the owner's merge rules.

Run the offline checker tests with Python 3.9 or newer:

```sh
python3 -m unittest discover -s tests -v
```

To verify a checked-in formula against the live release, run:

```sh
python3 .github/workflows/formula-check/verify_formula.py env-vault
python3 .github/workflows/formula-check/verify_formula.py macos-user-settings
```

When a project's release generator changes the formula structure, update its
template in this tap as part of the same reviewed change, before publishing
the new formula. For env-vault the generator is
`scripts/release/homebrew-formula.sh` in its source repository. Version and
checksum updates need no template change. Golden formula fixtures in
`tests/fixtures/` record the earlier releases used by the offline tests; they
do not follow later version bumps.
