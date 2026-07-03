class Aliast < Formula
  desc "Ghost-text autocompletion and natural-language commands for zsh"
  homepage "https://github.com/ChrisWoo0443/AliasT"
  version "1.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-aarch64-apple-darwin.tar.gz"
      sha256 "4e678d8d9767b8fbb017d56cc8f59503a2422efde54415c6f06e89f29d6eea8e"
    elsif Hardware::CPU.intel?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-x86_64-apple-darwin.tar.gz"
      sha256 "e9edf7d24c7b8cf17c857df2f3e25f55317779deeb29c74ac88757ca4a5bd8f2"
    end
  end

  def install
    bin.install "aliast"
    # The plugin ships inside the tarball since v1.3.0 -- one download,
    # one checksum, no separate resource.
    (share/"aliast").install "aliast.plugin.zsh"
  end

  def caveats
    <<~EOS
      To activate AliasT, add the following line to your ~/.zshrc:

        source #{HOMEBREW_PREFIX}/share/aliast/aliast.plugin.zsh

      Then restart your terminal or run:

        source ~/.zshrc

      The daemon (aliast) will start automatically the first time
      the plugin is loaded -- no manual startup required.
    EOS
  end

  test do
    assert_match "aliast", shell_output("#{bin}/aliast --version")
  end
end
