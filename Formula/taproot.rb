class Taproot < Formula
  desc "AI-driven specs, enforced at commit time"
  homepage "https://github.com/imix/taproot"
  url "https://github.com/imix/taproot/archive/refs/tags/v0.8.6.tar.gz"
  sha256 "6101887573144bc04848517474f9b2f84a2d32e80f7500c6fc979bbfe001a9fe"
  version "0.8.6"
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
