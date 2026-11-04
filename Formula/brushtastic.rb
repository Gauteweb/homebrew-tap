class Brushtastic < Formula
  desc "Menu bar app for drawing temporary, fading annotations over the whole screen"
  homepage "https://github.com/Gauteweb/Brushtastic"
  url "https://github.com/Gauteweb/Brushtastic/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "238f65e6639f3c81c9f13b8e025e97767d3dc77493883af77eb3da781390807f"
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
