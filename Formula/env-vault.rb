class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.16"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.16/env-vault-darwin-arm64.tar.gz"
      sha256 "7ddbc60007508eff30c56b8770caf52d46d7e0a3ddfc7d894fda7e96b2448989"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.16/env-vault-darwin-amd64.tar.gz"
      sha256 "afc3ed48d33cdaa1016a943b6f44809bc2dfbd015fa245f175e9c2b35aa2fc2f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.16/env-vault-linux-arm64.tar.gz"
      sha256 "bd6230d5ce64ac4b40fcdad29bd39920d0f37fa7a25228358c2906afa2c27b3f"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.16/env-vault-linux-amd64.tar.gz"
      sha256 "cf1621cc19a26755ee6c8296ce26fbb10d6ae1a5459b3015e01f89ba6958f98f"
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
