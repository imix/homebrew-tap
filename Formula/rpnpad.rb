class Rpnpad < Formula
  desc "An HP48-style RPN calculator for the terminal"
  homepage "https://github.com/imix/rpnpad"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imix/rpnpad/releases/download/v0.3.1/rpnpad-aarch64-apple-darwin.tar.xz"
      sha256 "9866d9259cfe21034a9532a022888bcb4900a63142ce0e909c6bc5c0c0074ef4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imix/rpnpad/releases/download/v0.3.1/rpnpad-x86_64-apple-darwin.tar.xz"
      sha256 "79f1fa2d795d00bc91a58b45ebaed903e5325aa08830609e15d1cad091cc7fdb"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/imix/rpnpad/releases/download/v0.3.1/rpnpad-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "78213f3257ca35b0b7f43715d2b00fb54ecf27ac8f1fc76afad611a4f7c0f7ac"
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
