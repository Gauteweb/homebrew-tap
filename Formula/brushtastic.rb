class Brushtastic < Formula
  desc "Menu bar app for drawing temporary, fading annotations over the whole screen"
  homepage "https://github.com/Gauteweb/Brushtastic"
  url "https://github.com/Gauteweb/Brushtastic/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "cfb3b8a328607b5f9513c56a5eb77c4e76ec115db92470fc74f0fa514c1733d4"
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
