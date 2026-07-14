# homebrew-tap

Homebrew formulae for [ildarbinanas-design](https://github.com/ildarbinanas-design) projects.

## Install

```sh
brew install ildarbinanas-design/tap/env-vault
```

Or tap first, then install:

```sh
brew tap ildarbinanas-design/tap
brew install env-vault
```

Works on macOS 15 Sequoia or newer (Apple Silicon and Intel) and Linux
(arm64 and amd64). The macOS minimum matches the environments used to build
and verify the CGO-enabled release binaries.
No `xattr -d com.apple.quarantine` needed — Homebrew downloads do not get the
Gatekeeper quarantine attribute.

## Upgrade

```sh
brew upgrade env-vault
```

## Formulae

| Formula | Description |
| --- | --- |
| [env-vault](Formula/env-vault.rb) | Secure environment variable vault for running commands with profiles |

Formulae are updated automatically by the release pipeline of the corresponding
project (see `.github/workflows/build-binaries.yml` in
[env-vault](https://github.com/ildarbinanas-design/env-vault)).
