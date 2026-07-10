class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.5/env-vault-darwin-arm64.tar.gz"
      sha256 "6fc9cbf7703ac64b99a188f496175c8c8aaa6c05d8956a63bd2b6db4eb91d04a"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.5/env-vault-darwin-amd64.tar.gz"
      sha256 "ad98d8eb2dc6c97e1e2a4a280798a058433a639a4ec591edc2ab1ea0edc93d0b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.5/env-vault-linux-arm64.tar.gz"
      sha256 "3186e07b2caedfa8a9af539c636fd4ea87e8f02fa126a8420abf04529d09c131"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.5/env-vault-linux-amd64.tar.gz"
      sha256 "9d8f723475ffd003d8ae34cdbdc717a5caba81929357a55833f101f5c6e4c7d7"
    end
  end

  def install
    bin.install "env-vault"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/env-vault --version")
  end
end
