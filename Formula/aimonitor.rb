class Aimonitor < Formula
  desc "Menu bar app showing Claude session and weekly usage (unofficial)"
  homepage "https://github.com/Gauteweb/aimonitor"
  url "https://github.com/Gauteweb/aimonitor/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "52ecd97478e3cf7a9b9e21e1d470afbc559ad4f7721a3d62387406e1e33d5801"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "./build.sh", "--build-only"
    prefix.install "build/AI Monitor for Claude.app"
  end

  def caveats
    <<~EOS
      Start the app with:
        open "#{opt_prefix}/AI Monitor for Claude.app"

      After `brew upgrade aimonitor`, quit the running app, open it again, and
      turn "Launch at login" off and on in its menu if you use it.
    EOS
  end

  test do
    app = prefix/"AI Monitor for Claude.app"
    assert_predicate app/"Contents/MacOS/AIMonitorForClaude", :executable?
    assert_match "net.gauteweb.aimonitor",
                 shell_output("/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' '#{app}/Contents/Info.plist'")
  end
end
