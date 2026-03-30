class Taproot < Formula
  desc "AI-driven specs, enforced at commit time"
  homepage "https://github.com/imix/taproot"
  url "https://github.com/imix/taproot/archive/refs/tags/v0.9.3.tar.gz"
  sha256 "6a2c3d45ae5fd86d60cf8d2332587f785aa95347996289849446a0fd8b7eeef8"
  version "0.9.3"
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
