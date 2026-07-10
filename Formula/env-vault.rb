class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.3/env-vault-darwin-arm64.tar.gz"
      sha256 "7c39e0f39fc0f70aa2c087a1f1b8aea87c9ed987b1184bd0b74c2ff395cc11a6"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.3/env-vault-darwin-amd64.tar.gz"
      sha256 "df7ccebaed0253709fe148917ee32711f22769ab9a66a276d1ff9b20071d2342"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.3/env-vault-linux-arm64.tar.gz"
      sha256 "091bd4725aff77932312fcc08e0260bc4120fed567d6e175499b673fb1b667cf"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.3/env-vault-linux-amd64.tar.gz"
      sha256 "41e2f222240e9fa3e4d3ccd74da6755d8ba4667d365fd8f599665fb8601238aa"
    end
  end

  def install
    bin.install "env-vault"
  end

  test do
    assert_match "env-vault", shell_output("#{bin}/env-vault --help")
  end
end
