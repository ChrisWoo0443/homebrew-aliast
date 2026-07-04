class Aliast < Formula
  desc "Ghost-text autocompletion and natural-language commands for zsh"
  homepage "https://github.com/ChrisWoo0443/AliasT"
  version "1.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-aarch64-apple-darwin.tar.gz"
      sha256 "f425cdc53cd2441c31e2a6e52c738a5c432d7f23dfc1afd625a82bbddfdf999f"
    elsif Hardware::CPU.intel?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-x86_64-apple-darwin.tar.gz"
      sha256 "d763ad5e03afd49c818fd5a88a3866af2aa91611201b3a5c356b805f13c03e01"
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
