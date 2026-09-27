class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.3.1"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.1/env-vault-darwin-arm64.tar.gz"
      sha256 "d53858f7efd3d007a18473f7c8deb60c98adf4d0a1bd3641419d63971e516b6e"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.1/env-vault-darwin-amd64.tar.gz"
      sha256 "231217e9d3d026cec55b0c0dfbe3315e0888c63faafb56bb71516207d70d4889"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.1/env-vault-linux-arm64.tar.gz"
      sha256 "70fc0b66d4de8f0838dc7b8b90932e1eb359ebdfc28d9d88685ad5a724ecc573"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.1/env-vault-linux-amd64.tar.gz"
      sha256 "1c6653101da867ea96f9a16522ae1ff806812198d8982e8e3d72f2ec16b44012"
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
