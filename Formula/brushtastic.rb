class Brushtastic < Formula
  desc "Menu bar app for drawing temporary, fading annotations over the whole screen"
  homepage "https://github.com/Gauteweb/Brushtastic"
  url "https://github.com/Gauteweb/Brushtastic/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "fc6a59a35796e939524bca8ff1d40f3ab7ebbd65b48132c2afc49c094b3ac18a"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "./build.sh"
    prefix.install "build/Brushtastic.app"
  end

  def caveats
    <<~EOS
      Start the app with:
        open "#{opt_prefix}/Brushtastic.app"

      Press Control-Option-D to start drawing.

      After `brew upgrade brushtastic`, quit the running app, open it again, and
      turn "Launch at Login" off and on in its menu if you use it.
    EOS
  end

  test do
    app = prefix/"Brushtastic.app"
    assert_predicate app/"Contents/MacOS/Brushtastic", :executable?
    assert_match "com.brushtastic.app",
                 shell_output("/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' '#{app}/Contents/Info.plist'")
  end
end
