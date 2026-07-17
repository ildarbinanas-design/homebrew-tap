class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.15"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.15/env-vault-darwin-arm64.tar.gz"
      sha256 "81bb81ecf81d481176edceb65791bac6ad101d7e7ebd9399d1506d71a6fc21b2"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.15/env-vault-darwin-amd64.tar.gz"
      sha256 "d9142b24ed0fd4c08317cb925f56c15a8e63a1cdad89b15b2ec5f8ad82b0a585"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.15/env-vault-linux-arm64.tar.gz"
      sha256 "a4ba3dc289f148f7b46b4728954bb15d548c98dc1f64ae747237bd9f944efcc8"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.15/env-vault-linux-amd64.tar.gz"
      sha256 "0912cb05d1b05d726a1ae02e7873407be192c74201e5d6c326174f35fa1ccdea"
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
