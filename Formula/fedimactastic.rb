class Fedimactastic < Formula
  desc "Fediverse client for Pleroma, Akkoma, GoToSocial and Mastodon (Mac edition of Feditastic)"
  homepage "https://github.com/Gauteweb/FediMactastic"
  url "https://github.com/Gauteweb/FediMactastic/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "4d5fdba4e2a30361631ace0d27ec26f4e30f978698016e6341e5a881fef9a1ca"
  license "GPL-3.0-or-later"

  depends_on macos: :sonoma

  def install
    system "./build-app.sh"
    prefix.install "FediMactastic.app"
  end

  def caveats
    <<~EOS
      Start the app with:
        open "#{opt_prefix}/FediMactastic.app"

      To find it in Launchpad and Spotlight, add a link in ~/Applications:
        mkdir -p ~/Applications && ln -sf "#{opt_prefix}/FediMactastic.app" ~/Applications/

      After `brew upgrade fedimactastic`, quit the running app and open it again.
    EOS
  end

  test do
    app = prefix/"FediMactastic.app"
    assert_predicate app/"Contents/MacOS/FediMactastic", :executable?
    assert_match "app.feditastic.mac",
                 shell_output("/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' '#{app}/Contents/Info.plist'")
  end
end
