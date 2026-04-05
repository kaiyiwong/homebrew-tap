class Takumi < Formula
  desc "The craftsman's toolkit for shaping video assets"
  homepage "https://github.com/kaiyiwong/takumi"
  url "https://github.com/kaiyiwong/takumi/archive/refs/heads/main.tar.gz"
  version "1.0.0"
  sha256 "35d4e7ef1156203b73537b0cab73a7c0246b9b723330304863091df7a45a1d8f"
  license "MIT"

  depends_on "ffmpeg"

  def install
    libexec.install "takumi.sh"
    libexec.install "commands"
    bin.install_symlink libexec/"takumi.sh" => "takumi"
  end

  test do
    assert_match "craftsman's toolkit", shell_output("#{bin}/takumi help")
  end
end
