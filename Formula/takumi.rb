class Takumi < Formula
  desc "The craftsman's toolkit for shaping video assets"
  homepage "https://github.com/kaiyiwong/takumi"
  url "https://github.com/kaiyiwong/takumi/archive/refs/tags/v1.2.5.tar.gz"
  sha256 "d093dff01e6db09aff5e33cf574033202de594a7c47eb4a9fdd7833769ee6b72"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "node"

  def install
    libexec.install "takumi.sh"
    libexec.install "commands"
    libexec.install "lib"
    libexec.install "bin"
    libexec.install "ui"
    libexec.install "mcp"

    (bin/"takumi").write <<~EOS
      #!/bin/bash
      export SCRIPT_DIR="#{libexec}"
      exec "#{libexec}/takumi.sh" "$@"
    EOS

    bin.install libexec/"bin/takumi-mcp"
  end

  def post_install
    system "npm", "install", "--prefix", libexec/"mcp", "--silent"
    system "npm", "install", "--prefix", libexec/"ui", "--silent"
  end

  test do
    assert_match "craftsman's toolkit", shell_output("#{bin}/takumi help")
  end
end
