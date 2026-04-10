class Aliast < Formula
  desc "Ghost-text autocompletion and natural-language commands for zsh"
  homepage "https://github.com/ChrisWoo0443/AliasT"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-daemon-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER_SHA256_ARM64"
    elsif Hardware::CPU.intel?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-daemon-x86_64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER_SHA256_X86_64"
    end
  end

  resource "plugin" do
    url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast.plugin.zsh"
    sha256 "PLACEHOLDER_SHA256_PLUGIN"
  end

  def install
    bin.install "aliast-daemon"
    resource("plugin").stage do
      (share/"aliast").install "aliast.plugin.zsh"
    end
  end

  def caveats
    <<~EOS
      To activate AliasT, add the following line to your ~/.zshrc:

        source #{HOMEBREW_PREFIX}/share/aliast/aliast.plugin.zsh

      Then restart your terminal or run:

        source ~/.zshrc

      The daemon (aliast-daemon) will start automatically the first time
      the plugin is loaded — no manual startup required.
    EOS
  end

  test do
    assert_match "aliast-daemon", shell_output("#{bin}/aliast-daemon --version")
  end
end
