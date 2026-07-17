class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.14"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.14/env-vault-darwin-arm64.tar.gz"
      sha256 "a7886ca55e1869ac6bcd8033f724a5e5332b2fd0a8a8e099dcda44cc197925b5"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.14/env-vault-darwin-amd64.tar.gz"
      sha256 "bef836e0c848c86fb2c438379c0834032de7abf3461a63c491a96d58a860edcd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.14/env-vault-linux-arm64.tar.gz"
      sha256 "a9865bcb44caa40947a32f303db9f80dcfa289e5db089ccb179d37b17acca78f"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.14/env-vault-linux-amd64.tar.gz"
      sha256 "63c08758c643b8f9b6be9874e1e433a4c4ab49b31d035af62491196379f4422b"
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
