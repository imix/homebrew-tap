class Rpnpad < Formula
  desc "An HP48-style RPN calculator for the terminal"
  homepage "https://github.com/imix/rpnpad"
  version "0.2.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.9/rpnpad-aarch64-apple-darwin.tar.xz"
      sha256 "714802823dd4585c5a48f9568ae4dc3bebfedbad445df31b674bc5d5f69fca63"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.9/rpnpad-x86_64-apple-darwin.tar.xz"
      sha256 "393966480146c1b3ba75cfa24f1a4776f954c3102e1b8cd2599469f7b1381d6a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/imix/rpnpad/releases/download/v0.2.9/rpnpad-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "066c5db4561f2107318cddc339d0edbd092118f2310624d794c4a1a4b35605fc"
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
