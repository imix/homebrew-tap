class Taproot < Formula
  desc "AI-driven specs, enforced at commit time"
  homepage "https://github.com/imix/taproot"
  url "https://github.com/imix/taproot/archive/refs/tags/v0.9.5.tar.gz"
  sha256 "60f1d7c6a41914ca9728e1e0bfb768fef1bab1ab381ed1ae72ede0aeeb4a087a"
  version "0.9.5"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/taproot", "--version"
  end
end
