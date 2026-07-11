cask "displace" do
  version "2.2.2"
  sha256 "e393e58c0e785c4f9ebdb4397ef007e28f988bc224389921dd6e1c92c60fc340"

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
  #
  # Invoked through /bin/sh (which always exists) instead of pointing
  # `executable:` straight at the app binary. Homebrew hard-errors an uninstall
  # when an absolute `executable:` is missing, which would wedge `brew upgrade`/
  # `uninstall` for anyone whose Displace.app was already deleted or moved. The
  # guard runs the uninstaller only when the binary is present and swallows a
  # non-zero exit, so a missing or failing app degrades to a no-op.
  uninstall quit:   "com.jeresalo.Displace",
            script: {
              executable: "/bin/sh",
              args:       [
                "-c",
                "bin=\"#{appdir}/Displace.app/Contents/MacOS/Displace\"; " \
                "[ -x \"$bin\" ] && \"$bin\" --uninstall || true",
              ],
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
