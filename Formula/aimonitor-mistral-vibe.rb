class AimonitorMistralVibe < Formula
  desc "Menu bar app showing Mistral Vibe usage and API requests (unofficial)"
  homepage "https://github.com/Gauteweb/aimonitor"
  url "https://github.com/Gauteweb/aimonitor/archive/refs/tags/mistral-vibe-v1.0.tar.gz"
  sha256 "dc0c71aac45fee365bc2b9962da24a0944a0b46a75da324d441e7b63db048619"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "./build.sh", "vibe", "--build-only"
    prefix.install "build/AI Monitor for Mistral Vibe.app"
  end

  def caveats
    <<~EOS
      Start the app with:
        open "#{opt_prefix}/AI Monitor for Mistral Vibe.app"

      Then choose "Log in to Mistral…" in its menu and log in once.

      After `brew upgrade aimonitor-mistral-vibe`, quit the running app, open it
      again, and turn "Launch at login" off and on in its menu if you use it.
    EOS
  end

  test do
    app = prefix/"AI Monitor for Mistral Vibe.app"
    assert_predicate app/"Contents/MacOS/AIMonitorForMistralVibe", :executable?
    assert_match "net.gauteweb.aimonitor.vibe",
                 shell_output("/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' '#{app}/Contents/Info.plist'")
  end
end
