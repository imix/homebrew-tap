class Taproot < Formula
  desc "AI-driven specs, enforced at commit time"
  homepage "https://github.com/imix/taproot"
  url "https://github.com/imix/taproot/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "6b3d7336d01160cda6d450b4990c83a5f60ce0f7778ffe2da7b3d9fdfd937fdd"
  version "1.2.0"
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
