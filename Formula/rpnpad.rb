class Rpnpad < Formula
  desc "An HP48-style RPN calculator for the terminal"
  homepage "https://github.com/imix/rpnpad"
  version "0.2.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.8/rpnpad-aarch64-apple-darwin.tar.xz"
      sha256 "87d168370a267ae8cb84fe9443242aeb3c73454b5ba45abaa841d1f03d1ce114"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.8/rpnpad-x86_64-apple-darwin.tar.xz"
      sha256 "25486057e0712088758575dcced0e5834bcb846d6bf85166457d6ab883feb4ef"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/imix/rpnpad/releases/download/v0.2.8/rpnpad-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "54cd7ba137bf7f5e9da17d0cf843f44227d93119bbc03536d7b23af902a68479"
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
