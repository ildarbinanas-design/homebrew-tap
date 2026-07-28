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
