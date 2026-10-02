class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.2"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.2/env-vault-darwin-arm64.tar.gz"
      sha256 "62b95d03fe93eef5fc048747220fce4bbecfb989480a93d2836f6f156c2ac574"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.2/env-vault-darwin-amd64.tar.gz"
      sha256 "049904f620167b824f6478597dcde690590d69f9c5317f8bf1848e611b94edc2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.2/env-vault-linux-arm64.tar.gz"
      sha256 "efd6db33d9e05b75969d50a5b33c92aba671d8951b57f8a8007a095467899c4b"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.2/env-vault-linux-amd64.tar.gz"
      sha256 "cdb9fea2ddacda70521edd77d18771371516c96faef9193418a21b700c9d5663"
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
