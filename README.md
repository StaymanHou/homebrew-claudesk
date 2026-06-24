# homebrew-claudesk

A [Homebrew](https://brew.sh) tap for [**Claudesk**](https://github.com/StaymanHou/Claudesk) — a macOS lite-IDE that puts the daily Claude Code + Sublime workflow in one window with multiple virtual workspaces inside it.

> **Apple Silicon only.** The release ships an `aarch64` build. Intel Macs are not supported.

## Install

```sh
brew tap StaymanHou/claudesk
brew install --cask --no-quarantine claudesk
```

The `--no-quarantine` flag matters — see below.

## Why `--no-quarantine`?

Claudesk v1 is an **unsigned** build (no Apple Developer ID / no notarization yet). macOS attaches a quarantine attribute to anything downloaded, and Gatekeeper blocks unsigned apps **at launch** — so without clearing it you'd get *"Claudesk can't be opened because Apple cannot check it for malicious software."*

`brew install --cask --no-quarantine claudesk` tells Homebrew not to attach the quarantine flag in the first place, so the app launches normally.

If you already installed **without** `--no-quarantine`, clear it once by hand:

```sh
xattr -dr com.apple.quarantine /Applications/Claudesk.app
```

Re-run that after each `brew upgrade claudesk` — quarantine re-attaches to the new bundle.

## Updating

```sh
brew update
brew upgrade --cask --no-quarantine claudesk
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
