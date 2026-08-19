cask "claudesk" do
  version "0.3.4"
  sha256 "31714ce19512cde62893d1a4cc442d756f82872e486a93482c7223403ff7bb8e"

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

    (Claudesk self-updates in-app after that — its updater clears quarantine on the new
    bundle itself. Re-run the command only if you `brew upgrade` to a newer cask build.)

    Claudesk also requires the `claude` (Claude Code) CLI installed and authenticated,
    and Sublime Text / Sublime Merge for the in-app launcher buttons.
  EOS
end
