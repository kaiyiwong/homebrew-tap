class Takumi < Formula
  desc "The craftsman's toolkit for shaping video assets"
  homepage "https://github.com/kaiyiwong/takumi"
  url "https://github.com/kaiyiwong/takumi/archive/refs/tags/v1.2.3.tar.gz"
  sha256 "0282b706db4f3b0f8f095e4fce4a6786bb9193034ea1a75a302efd003901477b"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "node"

  def install
    libexec.install "takumi.sh"
    libexec.install "commands"
    libexec.install "ui"
    libexec.install "mcp"

    (bin/"takumi").write <<~EOS
      #!/bin/bash
      export SCRIPT_DIR="#{libexec}"
      exec "#{libexec}/takumi.sh" "$@"
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
