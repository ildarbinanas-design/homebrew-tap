class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.6"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.6/env-vault-darwin-arm64.tar.gz"
      sha256 "518a3b564324490185ce493026c04d731d2c4f2f4a985d0475f8a6ed8c043d8f"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.6/env-vault-darwin-amd64.tar.gz"
      sha256 "e5dcdfd5e2129b9e18962a13e06c54c77c864b691820c00413bb6ca413f75375"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.6/env-vault-linux-arm64.tar.gz"
      sha256 "e4df755da39858fa7acf0c74090df755d10a5c3aa337e4333d754099b4cba4b6"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.6/env-vault-linux-amd64.tar.gz"
      sha256 "15406dd45c5d076f890c33ff14925fa56abf2b8202a4555457ab49503611cbc1"
    end
  end

  def install
    bin.install "env-vault"
    doc.install %w[README.md LICENSE THIRD_PARTY_NOTICES.md]
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/env-vault --version")

    # Profile mappings are metadata; this never opens a secret store.
    config = testpath/"config.yaml"
    system bin/"env-vault", "--config", config, "profile", "create", "brew-test"
    system bin/"env-vault", "--config", config, "profile", "add", "brew-test", "brew-token:BREW_TEST_TOKEN"
    show = "#{bin}/env-vault --config #{config} --json profile show brew-test"
    data = JSON.parse(shell_output(show)).fetch("data")
    assert_equal "brew-test", data.fetch("profile")
    assert_equal ["BREW_TEST_TOKEN"], data.fetch("secrets").map { |mapping| mapping.fetch("env") }
    system bin/"env-vault", "--config", config, "profile", "remove", "brew-test", "BREW_TEST_TOKEN"
    assert_empty JSON.parse(shell_output(show)).fetch("data").fetch("secrets")
  end
end
