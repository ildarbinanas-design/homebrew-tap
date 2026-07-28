class MacosUserSettings < Formula
  desc "Manage selected macOS user preferences from a strict YAML profile"
  homepage "https://github.com/ildarbinanas-design/macos-user-settings"
  version "0.1.0"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/ildarbinanas-design/macos-user-settings/releases/download/v0.1.0/macos-user-settings-darwin-arm64.tar.gz"
      sha256 "2b4ab1ab68ba109c79a72ac5d8bf0194c5743c5a3a6f77c10882256baf125576"
    end

    on_intel do
      url "https://github.com/ildarbinanas-design/macos-user-settings/releases/download/v0.1.0/macos-user-settings-darwin-amd64.tar.gz"
      sha256 "3c4d6dca55e37b69254ca81faecdeda33188fb0e85738ef828ba2775d6ed2185"
    end
  end

  def install
    bin.install "macos-user-settings"
  end

  test do
    assert_match(/\Amacos-user-settings v#{version} \([0-9a-f]{40}\)\z/, shell_output("#{bin}/macos-user-settings version").strip)
  end
end
