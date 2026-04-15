class Taproot < Formula
  desc "AI-driven specs, enforced at commit time"
  homepage "https://github.com/imix/taproot"
  url "https://github.com/imix/taproot/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "08b069e23349f5aacce57ba6c7cb401ac4b7d3bb35cc949cbecde91d3ce096a4"
  version "1.4.0"
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
