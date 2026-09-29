class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.0"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.0/env-vault-darwin-arm64.tar.gz"
      sha256 "12cd7dae4cebfc177aa883a047f8669bbe46f54ea1244b513bd1d06b908e3231"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.0/env-vault-darwin-amd64.tar.gz"
      sha256 "8e15da57c5b2877405e2a5b41b65ac711babdd64d5442410d6673d13d5b687ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.0/env-vault-linux-arm64.tar.gz"
      sha256 "c828298727d22c51e050356c7e20c053357892f75bcb6fb80e6894f87d46131a"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.0/env-vault-linux-amd64.tar.gz"
      sha256 "5c07ab2673686eaa2df1cb8d4d3bc292724e45b030d32cf867415f73414d1afc"
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
