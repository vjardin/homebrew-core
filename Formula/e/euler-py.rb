class EulerPy < Formula
  include Language::Python::Virtualenv

  desc "Project Euler command-line tool written in Python"
  homepage "https://github.com/iKevinY/EulerPy"
  url "https://github.com/iKevinY/EulerPy/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "0d2f633bc3985c8acfd62bc76ff3f19d0bfb2274f7873ec7e40c2caef315e46d"
  license "MIT"
  revision 2
  head "https://github.com/iKevinY/EulerPy.git", branch: "master"

  bottle do
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3664a44a6e45e6b966ce78ff993efcbdd117f158e8ef78b8606e24232c10a273"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "11f5dfb6a969a89b7a40330336e43fcc06f489043b636fee552b25c09a6c534f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "40993a34fc4bbefceb1ca7370a2b3ddd094cfbfeef9a46a7de2ff1174657ddb1"
    sha256 cellar: :any_skip_relocation, sonoma:         "f825cee5e8175be5899ceaf40d404d769b891add77396f4d2226498d9ad86415"
    sha256 cellar: :any_skip_relocation, ventura:        "df4ca6061b3d3b80bfa7eeb61a8de73b28a48c6a8fc6a00c954e6d7123f950c3"
    sha256 cellar: :any_skip_relocation, monterey:       "de2905475e72061e60f2ceb5f09b4f0da8470051e089ffd0243e9ee29e6e9a64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c570e81e52680c373bf09d4e2f4372275f36e3579fbd1603f9f8ca9f96ef04f"
  end

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/c9/3d/74c56f1c9efd7353807f8f5fa22adccdba99dc72f34311c30a69627a0fad/setuptools-69.1.0.tar.gz"
    sha256 "850894c4195f09c4ed30dba56213bf7c3f21d86ed6bdaafb5df5972593bfc401"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    require "open3"
    output = Open3.capture2("#{bin}/euler", stdin_data: "\n")
    # output[0] is the stdout text, output[1] is the exit code
    assert_match 'Successfully created "001.py".', output[0]
    assert_equal 0, output[1]
    assert_predicate testpath/"001.py", :exist?
  end
end
