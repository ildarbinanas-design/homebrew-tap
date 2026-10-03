class EnvVault < Formula
  desc "Secure environment variable vault for running commands with profiles"
  homepage "https://github.com/ildarbinanas-design/env-vault"
  version "0.4.5"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.5/env-vault-darwin-arm64.tar.gz"
      sha256 "50dda84784cd7f51f9c275420edc4587976256381684fa7d4c03683c80c61f91"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.5/env-vault-darwin-amd64.tar.gz"
      sha256 "2d3057cc54571ff148c135c4e97daa7b92091e1491acf4e970f338e7601e92f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.5/env-vault-linux-arm64.tar.gz"
      sha256 "497eace08910a7f13fd75465f5006ca013b51a44e237d2848269cdda1bc14450"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/env-vault/releases/download/v0.4.5/env-vault-linux-amd64.tar.gz"
      sha256 "0f4542ac14f45f2a96dba16fc104f81d4c5231509f6d1beeac6df4116ed0ccde"
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
