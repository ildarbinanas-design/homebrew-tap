class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.2.0"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.0/env-vault-darwin-arm64.tar.gz"
      sha256 "9422d9d7af8f2a16d02b39d8c6c5a36978e0d46eeaf2d508892018d47b77e542"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.0/env-vault-darwin-amd64.tar.gz"
      sha256 "579e82075843bf5199cfea814f2603e6613923281c1c7d03ef4c4797c073a208"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.0/env-vault-linux-arm64.tar.gz"
      sha256 "7da9c5837fd38d9dce8031c4aada481b58afd595155b45258d60208a3c943614"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.0/env-vault-linux-amd64.tar.gz"
      sha256 "52687a0e376f3843dd57368010bf448ad067047d3ea03f629a5e966921f6b889"
    end
  end

  def install
    bin.install "env-vault"
    doc.install %w[README.md LICENSE THIRD_PARTY_NOTICES.md]
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/env-vault --version").strip
  end
end
