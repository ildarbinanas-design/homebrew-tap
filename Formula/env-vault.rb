class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.6/env-vault-darwin-arm64.tar.gz"
      sha256 "882c9e0033d034451053664681e1bb53747a138c04aad0960f0481eb58b1318f"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.6/env-vault-darwin-amd64.tar.gz"
      sha256 "90a767acbe41759b0925a6b2b766114ca13f1355d05d4bbba3878717cf7dcfe5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.6/env-vault-linux-arm64.tar.gz"
      sha256 "0dce66ed10e1fd1ae69323f4b1ffe469e75e30d3ec60b93c38166665427c7503"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.6/env-vault-linux-amd64.tar.gz"
      sha256 "afe97b0a61fd99f68ad4863cb5b212772d3af4c969ad520e5532e2536a569e53"
    end
  end

  def install
    bin.install "env-vault"
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/env-vault --version").strip
  end
end
