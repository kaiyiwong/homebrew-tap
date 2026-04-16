class Takumi < Formula
  desc "The craftsman's toolkit for shaping video assets"
  homepage "https://github.com/kaiyiwong/takumi"
  url "https://github.com/kaiyiwong/takumi/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "c8817d981ab8a8b9edaa83630b8b8385b7bb339a7ce546bdbd9da58fdf754672"
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
