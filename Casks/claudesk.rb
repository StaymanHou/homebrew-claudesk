cask "claudesk" do
  version "0.5.2"
  sha256 "de883781fed77ad65c0b5cd5f8a466d96d3bb2f39f676d5f0ac315f72cc78393"

  url "https://github.com/StaymanHou/Claudesk/releases/download/v#{version}/Claudesk_#{version}_aarch64.dmg"
  name "Claudesk"
  desc "Lite-IDE for the Claude Code + Sublime workflow with virtual workspaces"
  homepage "https://github.com/StaymanHou/Claudesk"

  # Claudesk updates itself in-app (built-in updater, M10). Declaring auto_updates
  # tells Homebrew the app manages its own version, so a later `brew upgrade` reconciles
  # against the running bundle's Info.plist (CFBundleVersion) instead of downgrading a
  # self-updated app back to the cask's pinned version.
  auto_updates true
  # Apple Silicon only — the release ships an aarch64 .dmg.
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Claudesk.app"

  # Signed with a Developer ID certificate and notarized by Apple (v0.5.2+, M14 WP2).
  # The .dmg carries a stapled notarization ticket, so Gatekeeper admits it with no
  # quarantine workaround — no `xattr` step, and no need for the `--no-quarantine`
  # install flag Homebrew 6.x removed.

  zap trash: [
    "~/Library/Application Support/com.claudesk.app",
    "~/Library/Caches/com.claudesk.app",
    "~/Library/Preferences/com.claudesk.app.plist",
    "~/Library/Saved Application State/com.claudesk.app.savedState",
  ]

  caveats <<~EOS
    Claudesk requires the `claude` (Claude Code) CLI installed and authenticated,
    and Sublime Text / Sublime Merge for the in-app launcher buttons.

    Claudesk self-updates in-app; `brew upgrade` also works.
  EOS
end
