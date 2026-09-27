class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.3.2"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.2/env-vault-darwin-arm64.tar.gz"
      sha256 "09aae3098be3563b17082734890aabe3e973ff19fe4bb731137182f755b1fc22"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.2/env-vault-darwin-amd64.tar.gz"
      sha256 "7b873c0be31c5ed03b66d72723b1aac48b565651e679a45c48ea76bc5aceab4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.2/env-vault-linux-arm64.tar.gz"
      sha256 "737630c8c4d097d8bebe4a54754bcaa8c629ce9e2f97411ff48ac50e94b4d3c7"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.3.2/env-vault-linux-amd64.tar.gz"
      sha256 "08bed48b68d0039a2bb176d82ad0380b7a286a48002d6910b9bc761b0daaac4c"
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
