class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.7"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.7/env-vault-darwin-arm64.tar.gz"
      sha256 "43282302be3bcd6a70b408d1550e80fed8be58281ddc56aa0795e67d67180bf7"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.7/env-vault-darwin-amd64.tar.gz"
      sha256 "bcc03610a9e9ebe2538a4db2a46b0b32bbafc776fd72666369f6ff252c74022b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.7/env-vault-linux-arm64.tar.gz"
      sha256 "59bf31446231aa2a07ca7b065e03c7fcce6d6032c27313167bf6bbadea61b461"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.7/env-vault-linux-amd64.tar.gz"
      sha256 "e5226401a05b34ae27df14b464c15f1a4d8d9503466426aa9d2f3c8585f4e2c4"
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
