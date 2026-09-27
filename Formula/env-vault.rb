class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.3.4"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.4/env-vault-darwin-arm64.tar.gz"
      sha256 "d2c891b0f93835cc94ef65c195509198d9251dadb4999e3be3c1a8d583b73e2d"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.4/env-vault-darwin-amd64.tar.gz"
      sha256 "326ff390a01cda7b2a3fa5a47be8b904317126ed6c27cca558aa75678396f71f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.4/env-vault-linux-arm64.tar.gz"
      sha256 "0482c0238228a0a90a22a778aba66e67ff9524999bfede214fd76cbf4eddcd09"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.4/env-vault-linux-amd64.tar.gz"
      sha256 "6b5f4cea126f7616aa26544ed2dd1580db9be29d62d09e1d1fdfa3e79a56409c"
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
