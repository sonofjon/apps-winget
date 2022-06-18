# Reference: https://gist.github.com/dougwaldron/d510f2d67a922da169aca1aeff7e4c4d#file-installsoftware-ps1
#
# 1. Make sure the Microsoft App Installer is installed:
#    https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1
# 2. Edit the list of apps to install.
# 3. Run this script as administrator.

Write-Output "Installing Apps"
$apps = @(
    # Communication
    @{name = "teams"},
    @{name = "zoom"},
    # Dev
    @{name = "dbbrowser"},
    @{name = "git"},
    @{name = "terminal"},
    @{name = "vscode"},
    # Downloads
    @{name = "qbittorrent"},
    # Files
    @{name = "7zip"},
    @{name = "dropbox"},
    @{name = "wiztree"},
    # Library
    @{name = "dotnet.runtime.6"},
    @{name = "vc++2015-2022x64"},
    # @{name = "vc++2015-2022x86"},
    # Media
    @{name = "acrobatreader"},
    # Music
    @{name = "picard"},
    @{name = "spotify"},
    # Video
    @{name = "9P3JFR0CLLL6"},   # mpv (Unofficial)
    @{name = "plex-desktop"},
    @{name = "vlc"},
    # Productivity
    @{name = "evernote"},
    # Tools
    @{name = "auto-dark-mode"},
    @{name = "9NQ8Q8J78637"},   # AutoHotkey
    @{name = "bitwarden"},
    @{name = "Barrier"},
    @{name = "ccleaner"},
    @{name = "nmap"},
    @{name = "nomachine"},
    @{name = "powertoys"},
    @{name = "9WZDNCRFJ3PS"},   # Microsoft Remote Desktop
    @{name = "virt-viewer"},
    # Web
    @{name = "firefox"},
    @{name = "googlechrome"}
    # Unavailable
    # @{name = "moo0-system-monitor"},
    # Main machine only
    # @{name = "calibre"},
    # @{name = "mediamonkey"},
    # @{name = "thunderbird"},
    # @{name = "unifiedremote"},
    # @{name = "virtualbox"}
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing: " $app.name
        winget install --exact --silent --accept-source-agreements --accept-package-agreements $app.name
    }
    else {
        Write-host "Skipping: " $app.name " (already installed)"
    }
}
