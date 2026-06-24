cask "claudesk" do
  version "0.1.0"
  sha256 "3efb36262ce1cb20a257ae28600431dd8307c3b87220fabdf638647f3f460bad"

  url "https://github.com/StaymanHou/Claudesk/releases/download/v#{version}/Claudesk_#{version}_aarch64.dmg"
  name "Claudesk"
  desc "macOS lite-IDE for the Claude Code + Sublime workflow, with multiple virtual workspaces in one window"
  homepage "https://github.com/StaymanHou/Claudesk"

  # Apple Silicon only — the release ships an aarch64 .dmg.
  depends_on arch: :arm64

  app "Claudesk.app"

  # This build is UNSIGNED (no Apple Developer ID / no notarization yet).
  # macOS attaches a quarantine xattr that Gatekeeper blocks at launch.
  # Homebrew 6.x removed the `--no-quarantine` install flag, so the reliable
  # path is to install normally then clear the flag once (see caveats below).

  zap trash: [
    "~/Library/Application Support/com.claudesk.app",
    "~/Library/Caches/com.claudesk.app",
    "~/Library/Preferences/com.claudesk.app.plist",
    "~/Library/Saved Application State/com.claudesk.app.savedState",
  ]

  caveats <<~EOS
    Claudesk is an UNSIGNED build, so macOS Gatekeeper will block it on first launch.
    Clear the quarantine flag once:

      xattr -dr com.apple.quarantine "#{appdir}/Claudesk.app"

    (Re-run that after each `brew upgrade` — quarantine re-attaches to the new bundle.)

    Claudesk also requires the `claude` (Claude Code) CLI installed and authenticated,
    and Sublime Text / Sublime Merge for the in-app launcher buttons.
  EOS
end
