class Rpnpad < Formula
  desc "An HP48-style RPN calculator for the terminal"
  homepage "https://github.com/imix/rpnpad"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.6/rpnpad-aarch64-apple-darwin.tar.xz"
      sha256 "7ec334fe2ff031d2610fd4fb5b4dd295e696fca2051a292d36151bad6577359e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.6/rpnpad-x86_64-apple-darwin.tar.xz"
      sha256 "1880c9b183d8c2a94083e8a296e45b281802e93d7d7fbebf22fb43eef8c86d7c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/imix/rpnpad/releases/download/v0.2.6/rpnpad-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a445ba39b05bc37f104ffae17337a3510589181d98a39d69815393bf8b371b4e"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "rpnpad" if OS.mac? && Hardware::CPU.arm?
    bin.install "rpnpad" if OS.mac? && Hardware::CPU.intel?
    bin.install "rpnpad" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
