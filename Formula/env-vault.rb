class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.17"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.17/env-vault-darwin-arm64.tar.gz"
      sha256 "52f9a07b07a8a69622369eee1732a5d938c7bb58d49d7881ad4b01606e0137e8"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.17/env-vault-darwin-amd64.tar.gz"
      sha256 "fa39b2621953a80fc75edff3f73c309a650c8d0394b66a1f918b2fd027693969"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.17/env-vault-linux-arm64.tar.gz"
      sha256 "b51ed6dbbbb7bd6e91951fe03bd12aa7bef080858da9ea7d39c82492120880c0"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.17/env-vault-linux-amd64.tar.gz"
      sha256 "414624bec9c9204c6f41002eb5725ce1a4ee2e5dd46e2c3ef992dd60e3d4f800"
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
