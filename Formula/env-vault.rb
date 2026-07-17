class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.13"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.13/env-vault-darwin-arm64.tar.gz"
      sha256 "eb5671e517ac535879cabee7bb8697e75d7ed0e7f961f262138b8bcbb2f0a3e7"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.13/env-vault-darwin-amd64.tar.gz"
      sha256 "19eb1a910cf7ae79ae9562bf853f4d28394b038336a8ad22998b594a2d0057ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.13/env-vault-linux-arm64.tar.gz"
      sha256 "bbd1b0e153f3adb418605bf80176339a98eab1d575402e8aa44a035837bb4e96"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.13/env-vault-linux-amd64.tar.gz"
      sha256 "c2217b7188a3924bcf31f8b8157b8758f4771fb2d5b47f16326e217ecae5ca77"
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
