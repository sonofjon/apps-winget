# Reference: https://gist.github.com/dougwaldron/d510f2d67a922da169aca1aeff7e4c4d#file-installsoftware-ps1
#
# 1. Make sure the Microsoft App Installer (winget) is installed:
#      https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1
# 2. Install gsudo:
#      winget install gerardog.gsudo
# 3. Edit the list of apps to install
# 4. Copy this module to ~\Documents\WindowsPowerShell
# 5. Import this module with:
#      Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#      Import-Module ~\Documents\WindowsPowerShell\Install-AJ8Apps.psm1
# 6. Run script with gsudo:
#      gsudo Install-AJ8Apps [ -ComputerType {work|home|main} [,...]] ]
#
# TODO:
#  * Move app lists to separate files so that module does not need re-importing
#

function Install-AJ8Apps {

    param (
        [Parameter(Mandatory)]
        [ValidateSet('work', 'home', 'main')]
        [string[]]$ComputerType
    )

    foreach ($Type in $ComputerType) {

        switch ( $Type )
        {
            "work"
            {
                $apps = @(
                    # Dev
                    @{name = "DBBrowserForSQLite.DBBrowserForSQLite"},
                    @{name = "Docker.DockerDesktop"},
                    @{name = "Git.Git"},
                    @{name = "Microsoft.WindowsTerminal"},
                    @{name = "Microsoft.VisualStudioCode"},
                    # @{name = "WinMerge.WinMerge"},
                    # Files
                    @{name = "7zip.7zip"},
                    @{name = "Dropbox.Dropbox"},
                    @{name = "AntibodySoftware.WizTree"},
                    # Library
                    # @{name = "Microsoft.DotNet.Runtime.6"},
                    # @{name = "Microsoft.VC++2015-2022Redist-x64"},
                    # @{name = "Microsoft.VC++2015-2022Redist-x86"},
                    # Media
                    @{name = "Adobe.Acrobat.Reader.64-bit"},
                    # Tools
                    @{name = "Armin2208.WindowsAutoNightMode"},
                    # @{name = "9NQ8Q8J78637"},   # AutoHotkey
                    @{name = "9PLQFDG8HH9D"},   # AutoHotkey v2
                    @{name = "Bitwarden.Bitwarden"},
                    @{name = "BleachBit.BleachBit"},
                    # @{name = "moo0-system-monitor"},   # unavailable
                    # @{name = "Microsoft.PowerToys"},   # Powertoys Preview
                    @{name = "XP89DCGQ3K6VLD"}   # Powertoys
                    # @{name = "9WZDNCRFJ3PS"},   # Microsoft Remote Desktop
                )
            }
            "home"
            {
                $apps = @(
                    # Books
                    # @{name = "Amazon.Kindle"},
                    # Communication
                    @{name = "Jitsi.Meet"},
                    @{name = "Microsoft.Teams"},
                    @{name = "Zoom.Zoom"},
                    # Downloads
                    @{name = "qBittorrent.qBittorrent"},
                    # @{name = "webtorrent"},   # unavailable
                    # Music
                    # @{name = "Spotify.Spotify"},
                    # @{name = "9NCBCSZSJRSB"},   # Spotify
                    # Media
                    @{name = "9PD9BHGLFC7H"},   # Inkscape
                    # Productivity
                    @{name = "TheDocumentFoundation.LibreOffice"},
                    @{name = "Obsidian.Obsidian"},
                    # Tools
                    @{name = "acrosync.DuplicacyWeb"},
                    @{name = "QNAP.QfinderPro"},
                    # @{name = "RevoUninstaller.RevoUninstaller"},
                    @{name = "Rufus.Rufus"},
                    # @{name = "9PC3H3V7Q9CH"},   # Rufus
                    # @{name = "SumatraPDF.SumatraPDF"},
                    # @{name = "Synology.Assistant"},
                    # @{name = "Synology.DriveClient"},
                    # Video
                    @{name = "9P3JFR0CLLL6"},   # mpv (Unofficial)
                    @{name = "Plex.Plex"}, # Plex Desktop
                    # @{name = "Plex.PlexMediaPlayer"}, # Plex TV
                    @{name = "VideoLAN.VLC"},
                    # Web
                    @{name = "Google.Chrome"},
                    @{name = "Mozilla.Firefox"}
                )
            }
            "main"
            {
                $apps = @(
                    # Books
                    @{name = "Calibre.Calibre"},
                    @{name = "Amazon.SendToKindle"},
                    # Music
                    # @{name = "Apple.iTunes"},
                    @{name = "VentisMedia.MediaMonkey"},
                    @{name = "MusicBrainz.Picard"},
                    # Productivity
                    @{name = "Mozilla.Thunderbird"},
                    # Tools
                    @{name = "UnifiedIntents.UnifiedRemote"},
                    # @{name = "Oracle.VirtualBox"},
                    # @{name = "AndreWiethoff.ExactAudioCopy"}
                    # @{name = "HandBrake.HandBrake"},
                    # Video
                    # @{name = "Plex.PlexMediaServer"},
                    # Other
                    @{name = "Garmin.Express"}
                )
            }
        }

        foreach ($app in $apps) {
            $listApp = winget list --exact --query $app.name
            if (![String]::Join("", $listApp).Contains($app.name)) {
                Write-host "`nInstalling: " $app.name
                winget install --exact --silent --accept-source-agreements --accept-package-agreements --id $app.name
            }
            else {
                Write-host "`nSkipping: " $app.name " (already installed)"
            }
        }
    }
}
