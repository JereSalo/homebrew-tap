cask "displace" do
  version "1.2.0"
  sha256 "9bd4954ca87209ebf2fd76e8a2ec0d3e02fd81cd788e258fb5a71b3b183dc29d"

  url "https://api.displaceapp.com/download/#{version}",
      verified: "api.displaceapp.com/"
  name "Displace"
  desc "Arrange displays and move across them your way"
  homepage "https://displaceapp.com/"

  livecheck do
    url "https://api.displaceapp.com/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Displace.app"

  # Run the app's own uninstaller first: only Displace can unregister its
  # SMAppService login item and helper, so a plain delete would leave a ghost
  # login item behind. It also restores displays, frees the license slot, and
  # removes settings/logs. The zap below is a backstop.
  uninstall quit:   "com.jeresalo.Displace",
            script: {
              executable: "#{appdir}/Displace.app/Contents/MacOS/Displace",
              args:       ["--uninstall"],
              sudo:       false,
            }

  zap trash: [
    "~/Library/Application Support/Displace",
    "~/Library/Caches/com.jeresalo.Displace",
    "~/Library/HTTPStorages/com.jeresalo.Displace",
    "~/Library/HTTPStorages/com.jeresalo.Displace.binarycookies",
    "~/Library/Logs/Displace",
    "~/Library/Preferences/com.jeresalo.Displace.plist",
    "~/Library/Saved Application State/com.jeresalo.Displace.savedState",
  ]
end
