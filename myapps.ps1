# Reference: https://gist.github.com/dougwaldron/d510f2d67a922da169aca1aeff7e4c4d#file-installsoftware-ps1
#
# 1. Make sure the Microsoft App Installer (winget) is installed:
#      https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1
# 2. Install gsudo:
#      winget install gerardog.gsudo
# 2. Edit the list of apps to install
# 3. Run this script with gsudo:
#      gsudo powershell <script>.ps1

function Install-AJ8Apps {

    [CmdletBinding()]           # advanced function
    param (
        [Parameter(Mandatory)]  # mandatory value(s) for ComputerType
        [string[]]$ComputerType
        # [ValidateNotNullOrEmpty()] # provide default value
        # [string[]]$ComputerType = "work"
        PROCESS {
            foreach ($Type in $ComputerType) {
                try {
                    ["work", "home", "main"].Contains($Type) # ismember?
                }
                catch {
                    Write-Warning -Message "Unknown Computer type: $Type. Options are 'work', 'home' and 'main'"
                }
            }
        }
    )

    switch ( $ComputerType )
    {
        "work"
        {
            $apps = @(
                # Dev
                @{name = "DBBrowserForSQLite.DBBrowserForSQLite"},
                @{name = "Git.Git"},
                @{name = "Microsoft.WindowsTerminal"},
                @{name = "Microsoft.VisualStudioCode"},
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
                # Tools
                @{name = "Armin2208.WindowsAutoNightMode"},
                @{name = "9NQ8Q8J78637"},   # AutoHotkey
                @{name = "Bitwarden.Bitwarden"},
                @{name = "DebaucheeOpenSourceGroup.Barrier"},
                @{name = "Piriform.CCleaner"},
                @{name = "Insecure.Nmap"},
                # @{name = "moo0-system-monitor"},   # unavailable
                @{name = "NoMachine.NoMachine"},
                @{name = "Microsoft.PowerToys"},
                @{name = "9WZDNCRFJ3PS"},   # Microsoft Remote Desktop
                @{name = "RedHat.VirtViewer"},
                # Web
                @{name = "Mozilla.Firefox"},
                @{name = "Google.Chrome"}
            );

        }
        "home"
        {

            $apps = @(
                # Communication
                @{name = "Microsoft.Teams"},
                @{name = "Zoom.Zoom"},
                # Downloads
                @{name = "qBittorrent.qBittorrent"},
                # @{name = "webtorrent"},   # unavailable
                # Music
                @{name = "Spotify.Spotify"},
                # Productivity
                @{name = "evernote.evernote"},
                # Video
                @{name = "9P3JFR0CLLL6"},   # mpv (Unofficial)
                @{name = "Plex.Plex"}, # Plex Desktop
                # @{name = "Plex.PlexMediaPlayer"}, # Plex TV
                @{name = "VideoLAN.VLC"}
            );

        }
        "main"
        {
            $apps = @(
                # Media
                @{name = "calibre"},
                # Music
                @{name = "mediamonkey"},
                @{name = "MusicBrainz.Picard"},
                # Productivity
                @{name = "thunderbird"},
                # Tools
                @{name = "unifiedremote"},
                @{name = "virtualbox"},
                # Video
                @{name = "Plex.PlexMediaServer"}
            );
        }
    }

    Foreach ($app in $work) {
        $listApp = winget list --exact --query $app.name
        if (![String]::Join("", $listApp).Contains($app.name)) {
            Write-host "`nInstalling: " $app.name
            # winget install --exact --silent --accept-source-agreements --accept-package-agreements --id $app.name
        }
        else {
            Write-host "`nSkipping: " $app.name " (already installed)"
        }
    }
}
