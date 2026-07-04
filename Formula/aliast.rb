class Aliast < Formula
  desc "Ghost-text autocompletion and natural-language commands for zsh"
  homepage "https://github.com/ChrisWoo0443/AliasT"
  version "1.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-aarch64-apple-darwin.tar.gz"
      sha256 "84f246b458e5d80f526b620b32b7caaa0f0031fafd671a4150b3689b340ea013"
    elsif Hardware::CPU.intel?
      url "https://github.com/ChrisWoo0443/AliasT/releases/download/v#{version}/aliast-x86_64-apple-darwin.tar.gz"
      sha256 "58aaa48bc96509a29f6838e57795b672216602f10fd268733869a48494f8761c"
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
