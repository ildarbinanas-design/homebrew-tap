class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.2.1"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.1/env-vault-darwin-arm64.tar.gz"
      sha256 "ae3cc619604d19b6c878117dfd0a88397d557152bacf25c9a238da06a4bb4810"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.1/env-vault-darwin-amd64.tar.gz"
      sha256 "3536bc25b4c33ea594f828671a7fae4605fa92acadc0c7033e1bf98941376ca0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.1/env-vault-linux-arm64.tar.gz"
      sha256 "7c71c30fa4c4fd39417cf13bb0f866f80990f2e08310d756f25b8813189099b0"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.2.1/env-vault-linux-amd64.tar.gz"
      sha256 "032d4792021e7a33e3ed4d2968aa1fd892ced14ba024f239218b5baa31f56bf9"
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
