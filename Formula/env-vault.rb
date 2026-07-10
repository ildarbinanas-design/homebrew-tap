class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.2/env-vault-darwin-arm64.tar.gz"
      sha256 "f179d564d4557753070b83cd751bdc3cdbd77f91e7a6a1a2d48f8df01afd8f94"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.2/env-vault-darwin-amd64.tar.gz"
      sha256 "408910b04a45e69a50060eea13517c2f2158b551752097b52cdc308359f6bbb0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.2/env-vault-linux-arm64.tar.gz"
      sha256 "f51d3eba6dccbdab3b812fcc16bfa9337a818b1a07b2d9dac460d52346f06118"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.2/env-vault-linux-amd64.tar.gz"
      sha256 "f0d638425f199c330416fcd864ab4c0cf683ffd7982767bc1b1245265b4ef2cd"
    end
  end

  def install
    bin.install "env-vault"
  end

  test do
    assert_match "env-vault", shell_output("#{bin}/env-vault --help")
  end
end
