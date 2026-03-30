class Taproot < Formula
  desc "AI-driven specs, enforced at commit time"
  homepage "https://github.com/imix/taproot"
  url "https://github.com/imix/taproot/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "1f50ab7d7aba25b6c55bb9c210100dab1af9290568a5e4724d54b23efaf5f165"
  version "0.9.0"
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
