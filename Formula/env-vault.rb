class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.4"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.4/env-vault-darwin-arm64.tar.gz"
      sha256 "596d2e6716f39201438f1cb2dc999352a483add9344502bdf171aa296cae9568"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.4/env-vault-darwin-amd64.tar.gz"
      sha256 "1bcce0039d3a520ec0321552867e19ac9a8650fbacb1d7f30db8a55a9e6ba1ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.4/env-vault-linux-arm64.tar.gz"
      sha256 "2ddaaa424b1d682223909c315f6b75832ba7a5a788a40dcae048a7f74ac7eefc"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.4/env-vault-linux-amd64.tar.gz"
      sha256 "ff4a694717592a964afb4deaa1680a9a4baa18ff763857034687c5c1648e5687"
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
