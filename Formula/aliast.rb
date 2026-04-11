class Aliast < Formula
  desc "Ghost-text autocompletion and natural-language commands for zsh"
  homepage "https://github.com/ChrisWoo0443/AliasT"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-aarch64-apple-darwin.tar.gz"
      sha256 "c9d3b393151cec13f28fd2f1bfc90ec2208aea8c55e72dde1465182f11e6484a"
    elsif Hardware::CPU.intel?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-x86_64-apple-darwin.tar.gz"
      sha256 "9035015f3716ea048fefb0a277725e5d4920612cce1b308d75219be088bc8c77"
    end
  end

  resource "plugin" do
    url "https://github.com/ChrisWoo0443/AliasT/releases/download/v1.2.0/aliast.plugin.zsh"
    sha256 "65c976fc6df53b557d3bc4faaf6f31a478e79385108e37862fd901c48704c70b"
  end

  def install
    bin.install "aliast"
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

      The daemon (aliast) will start automatically the first time
      the plugin is loaded — no manual startup required.
    EOS
  end

  test do
    assert_match "aliast", shell_output("#{bin}/aliast --version")
  end
end
