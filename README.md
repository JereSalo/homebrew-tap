# homebrew-tap

Homebrew tap for [Displace](https://displaceapp.com), a macOS app that lets you arrange your displays freely and control how the cursor moves between them.

## Install

```sh
brew install --cask jeresalo/tap/displace
```

The main download lives at [displaceapp.com](https://displaceapp.com); this tap is just an alternate install path. Displace updates itself through Sparkle, so it's an `auto_updates` cask and `brew upgrade` leaves it alone.

## Uninstall

```sh
brew uninstall --cask displace
```

This runs Displace's built-in uninstaller first (restores your displays, unregisters the login item and helper, frees the license slot, removes settings and logs), then deletes the app.
