class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.1.0"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.1.0/env-vault-darwin-arm64.tar.gz"
      sha256 "1414cf087a66e663a65e6fc43b06d56dc0121c5eee7864031a15231dd0534409"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.1.0/env-vault-darwin-amd64.tar.gz"
      sha256 "2dec8d2c76ea0a7177189751dc841e5fb6c0290b890752670793a58a0576f617"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.1.0/env-vault-linux-arm64.tar.gz"
      sha256 "cfe0a0ea995c686e2dea02b6cbfe718a392e9c9c6a728972e9dd52c1380747b9"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.1.0/env-vault-linux-amd64.tar.gz"
      sha256 "93a1cbf23239391c3fa549f5fb37d4aa4649518c2d3e8ba1f1d1374f4e1460c5"
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
