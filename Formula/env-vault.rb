class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.4/env-vault-darwin-arm64.tar.gz"
      sha256 "a1ad63c873d4748b166bde09c588bfd52aa7eb33f0b75d64718ac38870985ebf"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.4/env-vault-darwin-amd64.tar.gz"
      sha256 "b5f55ce23f4157a058a3fbf0a1fa1e4e8220bb66e3500fb617373c8fedbd5473"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.4/env-vault-linux-arm64.tar.gz"
      sha256 "2f1d8014775e677213d9b15416ba408ae5268f62c77510a2152d03680ce1a7f5"
    else
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.0.4/env-vault-linux-amd64.tar.gz"
      sha256 "a15ce6024633bc8fd585885ebca8dc9b1ba0eaf3c9a664c82318749a79197ec0"
    end
  end

  def install
    bin.install "env-vault"
  end

  test do
    assert_match "env-vault", shell_output("#{bin}/env-vault --help")
  end
end
