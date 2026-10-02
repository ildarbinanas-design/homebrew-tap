class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.3"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.3/env-vault-darwin-arm64.tar.gz"
      sha256 "e01af0ad74d386e48afdee5f30fe99507085737ea4931dda0dd9203888a8e24c"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.3/env-vault-darwin-amd64.tar.gz"
      sha256 "f324c965baa263ed5dd232e4430b15351e9b21acd165c0a1fc60f0a5d77bc4b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.3/env-vault-linux-arm64.tar.gz"
      sha256 "85bda63111e39837f752c2685a917b85235806e3d734cb97340e2e6965becb23"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.3/env-vault-linux-amd64.tar.gz"
      sha256 "eddb2896aa130f710e88d3f356ba55d748bad2bb2f62ffaa2f9e1b0c5cee15a9"
    end
  end

  def install
    bin.install "env-vault"
    doc.install %w[README.md LICENSE THIRD_PARTY_NOTICES.md]
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/env-vault --version")
  end
end
