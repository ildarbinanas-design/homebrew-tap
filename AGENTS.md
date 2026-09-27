# homebrew-tap Agent Rules

This tap publishes the owner's personal CLIs through Homebrew: `env-vault` and
`macos-user-settings`. A formula must install exactly the binaries its project
released, so integrity outranks convenience.

## Hard Rules

- `Formula/env-vault.rb` is written only by the env-vault release workflow
  (`scripts/release/generate-homebrew-formula.sh` and
  `scripts/release/publish-homebrew-pr.sh` in env-vault). It opens the formula
  pull request and merges it head-guarded after the `test` check passes, and it
  compares the formula byte for byte. Never edit it by hand; change the
  generator in env-vault instead.
- `Formula/macos-user-settings.rb` pins that project's release archives. Change
  `version`, every `url`, and every `sha256` together, and take each checksum
  from the checksums the release published, never from a local build.
- A formula change reaches `main` only through a pull request whose exact head
  passed `.github/workflows/test-formula.yml`. The `main` ruleset requires the
  check named `test`; keep that name.
- Keep `brew audit --strict`. Every `--except` needs a comment that says why and
  what stays checked.
- Pin every action by full commit SHA and keep `permissions: contents: read`.
- This repository holds no secrets and needs none.

## Working Mode

The Working Mode section of env-vault's `AGENTS.md`
(<https://github.com/ildarbinanas-design/env-vault/blob/main/AGENTS.md#working-mode>)
governs this repository too: the Standing Delegation and how to ask the
owner. Read it before any write.
