class Takumi < Formula
  desc "The craftsman's toolkit for shaping video assets"
  homepage "https://github.com/kaiyiwong/takumi"
  url "https://github.com/kaiyiwong/takumi/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "e2fb78c059984f0e92cce3d84d52be951b1f3d9fb8196842f8e4c5ea434d6a0b"
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
