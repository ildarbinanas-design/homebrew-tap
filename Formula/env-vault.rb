class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.18"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.18/env-vault-darwin-arm64.tar.gz"
      sha256 "a54d29f44132aa1498e456d563de55bf11178ed5c0dfb3b993d5ec4f0e9f9d3a"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.18/env-vault-darwin-amd64.tar.gz"
      sha256 "1c2d3f67b577352375dbc73a27f5f3bbf8d8275561c1524d873677d05431e4ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.18/env-vault-linux-arm64.tar.gz"
      sha256 "2c8b18de4a65f3a35d504973c17571919cdbe454da9d8b63feeb05de9c03c548"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.18/env-vault-linux-amd64.tar.gz"
      sha256 "4dc60e662b1427e5e2ac00d74f7a03d36d8aeae3292745e1e168b4446f717199"
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
