class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.7"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.7/env-vault-darwin-arm64.tar.gz"
      sha256 "4fceadde40a7baa08b08d45cc9ce99181e25fd2bc10ca997f946f1cb1f02c6e1"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.7/env-vault-darwin-amd64.tar.gz"
      sha256 "f8a679349cfa3ee9f2aa1852b6db41c9e1c58c3e112b4361424ca3518c1efada"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.7/env-vault-linux-arm64.tar.gz"
      sha256 "38772260b7bb273a095867c3a8d1410f94b435e28313b61ade246a7b6cc360f3"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.7/env-vault-linux-amd64.tar.gz"
      sha256 "fa295e0499a7854d343dd4d2b813c5f29889f865ad9f642500d26a850341a754"
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
