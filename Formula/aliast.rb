class Aliast < Formula
  desc "Ghost-text autocompletion and natural-language commands for zsh"
  homepage "https://github.com/ChrisWoo0443/AliasT"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-daemon-aarch64-apple-darwin.tar.gz"
      sha256 "e44783b183acf28ff7c08b12e9be0d2e94a9d1b1bb64dff649937f9ae3e7035f"
    elsif Hardware::CPU.intel?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-daemon-x86_64-apple-darwin.tar.gz"
      sha256 "dce9ae8a54d1a94c8f55406f7a8f3708902fc7d95e54443504a25696bd07d576"
    end
  end

  resource "plugin" do
    url "https://github.com/ChrisWoo0443/AliasT/releases/download/v0.1.0/aliast.plugin.zsh"
    sha256 "0a67a0e454d0f1f6a9a2918000835c4ce14912914df3929003f929534d73dfed"
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
