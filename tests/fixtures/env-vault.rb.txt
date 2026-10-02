class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.1"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.1/env-vault-darwin-arm64.tar.gz"
      sha256 "57f61cc692a1314038993604ad7143093261063e169e82f02d9a4ae7ec653664"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.1/env-vault-darwin-amd64.tar.gz"
      sha256 "a1e43ffa8931a4dd51bb17d61ee768747b1e488e5a61ec1f1ec2988fa89c110f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.1/env-vault-linux-arm64.tar.gz"
      sha256 "2470911cc7e6655de29cc32186eef208922408b51dd70ce78cff853e94d02dd3"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.1/env-vault-linux-amd64.tar.gz"
      sha256 "c28f0011e686686ce9928f81fa494dc3ce56461a113368917f5bb7b4943ae1af"
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
