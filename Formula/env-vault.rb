class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.3.0"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.0/env-vault-darwin-arm64.tar.gz"
      sha256 "206e190eeebdc678e72154be75fc8bb80d397e4d1938a1b5413f3c0a7c5edae3"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.0/env-vault-darwin-amd64.tar.gz"
      sha256 "6e74845340441499703da354868492740dbbd2fb23cf8b91c8a2c3aee67bc8b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.0/env-vault-linux-arm64.tar.gz"
      sha256 "3071606969aa9eb3c861249bff6d7c31ede6be7890a66c9263b3739f89fb1b0d"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.0/env-vault-linux-amd64.tar.gz"
      sha256 "a06cbead85b42f85c48d2149816a0a803cd0c43baca8033f83d2058eaf36f1f1"
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
