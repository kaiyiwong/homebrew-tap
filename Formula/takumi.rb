class Takumi < Formula
  desc "The craftsman's toolkit for shaping video assets"
  homepage "https://github.com/kaiyiwong/takumi"
  url "https://github.com/kaiyiwong/takumi/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "fc60281aed89e6d39c97752bceebc3a3eda2b4837e5bc00a03fe2b88cc4ca2de"
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

    (bin/"takumi-mcp").write <<~EOS
      #!/bin/bash
      export SCRIPT_DIR="#{libexec}"
      exec "#{libexec}/bin/takumi-mcp"
    EOS
  end

  def post_install
    system "npm", "install", "--prefix", libexec/"mcp", "--silent"
    system "npm", "install", "--prefix", libexec/"ui", "--silent"
  end

  test do
    assert_match "craftsman's toolkit", shell_output("#{bin}/takumi help")
  end
end
