# homebrew-claudesk

A [Homebrew](https://brew.sh) tap for [**Claudesk**](https://github.com/StaymanHou/Claudesk) — a macOS lite-IDE that puts the daily Claude Code + Sublime workflow in one window with multiple virtual workspaces inside it.

> **Apple Silicon only.** The release ships an `aarch64` build. Intel Macs are not supported.

## Install

```sh
brew tap StaymanHou/claudesk
brew trust --cask StaymanHou/claudesk/claudesk
brew install --cask claudesk
xattr -dr com.apple.quarantine /Applications/Claudesk.app
```

Three steps that matter here:

- **`brew trust`** — recent Homebrew versions refuse to load casks from third-party taps until you explicitly trust them (*"Refusing to load cask … from untrusted tap"*). One-time-per-tap acknowledgement that you trust this source.
- **`brew install --cask claudesk`** — downloads the `.dmg`, checks its SHA-256, and installs `Claudesk.app` to `/Applications`.
- **`xattr -dr com.apple.quarantine …`** — Claudesk is unsigned, so macOS quarantines it and Gatekeeper blocks it at launch. This clears the flag once. (Homebrew 6.x removed the old `--no-quarantine` install flag, so this manual step is the reliable path.)

## Why the `xattr` step?

Claudesk v1 is an **unsigned** build (no Apple Developer ID / no notarization yet). macOS attaches a quarantine attribute to anything downloaded, and Gatekeeper blocks unsigned apps **at launch** — so without clearing it you'd get *"Claudesk can't be opened because Apple cannot check it for malicious software."*

```sh
xattr -dr com.apple.quarantine /Applications/Claudesk.app
```

clears that flag, and the app launches normally. (Homebrew used to offer a `--no-quarantine` install flag that avoided this, but Homebrew 6.x removed it — so this one-line step is the reliable path.)

Re-run it after each `brew upgrade claudesk` — quarantine re-attaches to the new bundle.

## Updating

```sh
brew update
brew upgrade --cask claudesk
xattr -dr com.apple.quarantine /Applications/Claudesk.app
```

## Uninstall

```sh
brew uninstall --cask claudesk          # remove the app
brew uninstall --cask --zap claudesk    # also remove app-support data, caches, prefs
```

## Requirements

- macOS on Apple Silicon
- [`claude`](https://docs.claude.com/claude-code) (Claude Code CLI) installed and authenticated
- Sublime Text and Sublime Merge (for the in-app launcher buttons)

## Notes

- This is the project's **own** tap. The official `homebrew-cask` tap rejects unsigned/un-notarized apps, so Claudesk is distributed here instead.
- Signing + notarization (which removes the quarantine step entirely) and in-app auto-update are planned for a later release.
