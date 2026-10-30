class Aimonitor < Formula
  desc "Menu bar app showing Claude session and weekly usage (unofficial)"
  homepage "https://github.com/Gauteweb/aimonitor"
  url "https://github.com/Gauteweb/aimonitor/archive/refs/tags/v1.1.tar.gz"
  sha256 "159b762bf35bd1232a70b4ae632291bc4f8fc114cfb2258af7a846c491333ffd"
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
