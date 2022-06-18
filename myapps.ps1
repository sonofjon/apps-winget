# Reference: https://gist.github.com/dougwaldron/d510f2d67a922da169aca1aeff7e4c4d#file-installsoftware-ps1
#
# 1. Make sure the Microsoft App Installer is installed:
#    https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1
# 2. Edit the list of apps to install.
# 3. Run this script as administrator.

Write-Output "Installing Apps"
$apps = @(
    # Communication
    @{name = "Microsoft.Teams"},
    @{name = "Zoom.Zoom"},
    # Dev
    @{name = "DBBrowserForSQLite.DBBrowserForSQLite"},
    @{name = "Git.Git"},
    @{name = "Microsoft.WindowsTerminal"},
    @{name = "Microsoft.VisualStudioCode"},
    # Downloads
    @{name = "qBittorrent.qBittorrent"},
    # Files
    @{name = "7zip.7zip"},
    @{name = "Dropbox.Dropbox"},
    @{name = "AntibodySoftware.WizTree"},
    # Library
    @{name = "Microsoft.DotNet.Runtime.6"},
    @{name = "Microsoft.VC++2015-2022Redist-x64"},
    # @{name = "Microsoft.VC++2015-2022Redist-x86"},
    # Media
    @{name = "Adobe.Acrobat.Reader.64-bit"},
    # Music
    @{name = "Spotify.Spotify"},
    # Video
    @{name = "9P3JFR0CLLL6"},   # mpv (Unofficial)
    @{name = "Plex.PlexMediaPlayer"},
    @{name = "VideoLAN.VLC"},
    # Productivity
    @{name = "evernote.evernote"},
    # Tools
    @{name = "Armin2208.WindowsAutoNightMode"},
    @{name = "9NQ8Q8J78637"},   # AutoHotkey
    @{name = "Bitwarden.Bitwarden"},
    @{name = "DebaucheeOpenSourceGroup.Barrier"},
    @{name = "Piriform.CCleaner"},
    @{name = "Insecure.Nmap"},
    @{name = "NoMachine.NoMachine"},
    @{name = "Microsoft.PowerToys"},
    @{name = "9WZDNCRFJ3PS"},   # Microsoft Remote Desktop
    @{name = "RedHat.VirtViewer"},
    # Web
    @{name = "Mozilla.Firefox"},
    @{name = "Google.Chrome"}
    # Unavailable
    # @{name = "moo0-system-monitor"},
    # @{name = "webtorrent"},
    # Main machine only
    # @{name = "calibre"},
    # @{name = "mediamonkey"},
    # @{name = "MusicBrainz.Picard"},
    # @{name = "Plex.PlexMediaServer"},
    # @{name = "thunderbird"},
    # @{name = "unifiedremote"},
    # @{name = "virtualbox"}
);
Foreach ($app in $apps) {
    $listApp = winget list --exact --query $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing: " $app.name
        winget install --exact --silent --accept-source-agreements --accept-package-agreements --id $app.name
    }
    else {
        Write-host "Skipping: " $app.name " (already installed)"
    }
}
