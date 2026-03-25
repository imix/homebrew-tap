class Rpnpad < Formula
  desc "An HP48-style RPN calculator for the terminal"
  homepage "https://github.com/imix/rpnpad"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.7/rpnpad-aarch64-apple-darwin.tar.xz"
      sha256 "d57d85cc29fb8a5c0abc72095c0973b7870606230a3f1ba8eea01e13f585782f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imix/rpnpad/releases/download/v0.2.7/rpnpad-x86_64-apple-darwin.tar.xz"
      sha256 "f1b909f6eed7736074650d6f4830e2b3156e17a45e151745f4246e6ae429d702"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/imix/rpnpad/releases/download/v0.2.7/rpnpad-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "31f91b430c01c2d3b23fce64dfe84be3c8fbe628526c9c3f165265cac0df2e2f"
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
