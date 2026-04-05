class Takumi < Formula
  desc "The craftsman's toolkit for shaping video assets"
  homepage "https://github.com/kaiyiwong/takumi"
  url "https://github.com/kaiyiwong/takumi/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "05a84c63f234a5f4fe87a700bbf922aa1b7094271359912b286de67e079cdd7e"
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
