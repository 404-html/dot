
#!/usr/bin/env bash

# largely gr(i/a)fted from:
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

cat << EOF

####################################

By flipping several dozen defaults
 you can make your Mac hackerrific.

 Follow the prompts
 Deep breaths
 Drink water

####################################

EOF

###############################################################################
# General UI/UX                                                               #
###############################################################################

ComputerName="kevin"

printf "%s " "Setting your computer name (as done via System Preferences → Sharing)"
scutil --set ComputerName $ComputerName
scutil --set HostName $ComputerName
scutil --set LocalHostName $ComputerName
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $ComputerName

# printf "%s\n" "Hiding the useless menubar icons?"
# defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

printf "%s\n" "Disabling OS X Gate Keeper"
printf "%s\n" "(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable

printf "%s\n" "Increasing the window resize speed for Cocoa applications whether you like it or not"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

printf "%s\n" "Expanding save and print panels by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

printf "%s\n" "Disabling the 'Are you sure you want to open this application from the Internet?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
printf "%s\n" "Displaying ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# printf "%s\n" "Disabling system-wide resume"
# defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

printf "%s\n" "Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

printf "%s\n" "Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

printf "%s\n" "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# printf "%s\n" ""
# printf "%s\n" "Never go into computer sleep mode"
# systemsetup -setcomputersleep Off > /dev/null

printf "%s\n" "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

printf "%s\n" "Disabling smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

printf "%s\n" "Disabling smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

printf "%s\n" "Enabling tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

printf "%s\n" "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

printf "%s\n" "Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# printf "%s\n" "Disabling press-and-hold for keys in favor of key repeat "
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

printf "%s\n" "Setting a blazingly fast keyboard repeat rate (ain't nobody got time fo special chars while coding!)"
defaults write NSGlobalDomain KeyRepeat -int 1

printf "%s\n" "Disabling auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

printf "%s\n" "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

printf "%s\n" "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
# Screen                                                                      #
###############################################################################

# printf "%s\n" "Requiring password immediately after sleep or screen saver begins"
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# printf "%s\n" "Where do you want screenshots to be stored? (hit ENTER if you want ~/Desktop as default)"
# read screenshot_location
# if [ -z "$1" ]
# then
#    printf "%s\n" "Setting location to ~/Desktop"
#    defaults write com.apple.screencapture location -string "$HOME/Desktop"
# else
#    printf "%s\n" "Setting location to ~/$screenshot_location"
#    defaults write com.apple.screencapture location -string "$HOME/$screenshot_location"
# fi

# printf "%s\n" "What format should screenshots be saved as? (hit ENTER for PNG, options: BMP, GIF, JPG, PDF, TIFF) "
# read screenshot_format
# if [ -z "$1" ]
# then
#    printf "%s\n" "Setting screenshot format to PNG"
#    defaults write com.apple.screencapture type -string "png"
# else
#    printf "%s\n" "Setting screenshot format to $screenshot_format"
#    defaults write com.apple.screencapture type -string "$screenshot_format"
# fi


printf "%s\n" "Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

###############################################################################
# Finder                                                                      #
###############################################################################

printf "%s\n" "Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true


printf "%s\n" "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

printf "%s\n" "Finder: show hidden files by default?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) defaults write com.apple.Finder AppleShowAllFiles -bool true
      break;;
    No ) break;;
  esac
done

printf "%s\n" "Finder: show dotfiles?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) defaults write com.apple.finder AppleShowAllFiles TRUE
      break;;
    No ) break;;
  esac
done

printf "%s\n" "Finder: showing all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

printf "%s\n" "Finder: showing status bar"
defaults write com.apple.finder ShowStatusBar -bool true

printf "%s\n" "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

printf "%s\n" "Finder: allowing text selection in Quick Look/Preview"
defaults write com.apple.finder QLEnableTextSelection -bool true

printf "%s\n" "Displaying full POSIX path as Finder window title?"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

printf "%s\n" "Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

printf "%s\n" "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

printf "%s\n" "Avoiding creating stupid .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

printf "%s\n" "Disabling disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

printf "%s\n" "Enable snap-to-grid for icons on the desktop and in other icon views?"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# printf "%s\n" "Setting Trash to empty securely by default"
# defaults write com.apple.finder EmptyTrashSecurely -bool true

printf "%s\n" "Showing the ~/Library folder"
chflags nohidden ~/Library

###############################################################################
# Dock & Mission Control
###############################################################################

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array

printf "%s\n" "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

printf "%s\n" "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

printf "%s\n" "Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

printf "%s\n" "Setting Dock to 2D mode"
defaults write com.apple.dock no-glass -boolean YES

printf "%s\n" "Pinning the Dock to the left side of the screen for most efficient use of screen realestate"
defaults write com.apple.dock pinning -string "end"


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

printf "%s\n" "Hiding Safari's bookmark bar"
defaults write com.apple.Safari ShowFavoritesBar -bool false

printf "%s\n" "Disabling Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

printf "%s\n" "Enabling Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

printf "%s\n" "Making Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

printf "%s\n" "Removing useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

printf "%s\n" "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

printf "%s\n" "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Messsages, Address Book and iTunes                                                     #
###############################################################################

printf "%s\n" "Disabling smart quotes as it’s annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

printf "%s\n" "Disabling continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

# printf "%s\n" ""
# printf "%s\n" "Enabling iTunes track notifications in the Dock"
# defaults write com.apple.dock itunes-notifications -bool true

printf "%s\n" "Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
      break;;
    No ) break;;
  esac
done

printf "%s\n" "Enabling the debug menu in Disk Utility"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

printf "%s\n" "Enabling UTF-8 ONLY in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4
printf "%s\n" "Setting the Pro theme as default"
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

###############################################################################
# Time Machine                                                                #
###############################################################################

printf "%s\n" "Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

printf "%s\n" "Disabling local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Personal Additions                                                          #
###############################################################################

# printf "%s\n" "Deleting space hogging sleep image and disabling"
# sudo rm /private/var/vm/sleepimage
# sudo pmset -a hibernatemode 0

printf "%s\n" "Speeding up wake from sleep to 24 hours from an hour"
"http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/"
pmset -a standbydelay 86400

printf "%s\n" "Disabling OS X logging of downloaded files" "http://www.macgasm.net/2013/01/18/good-morning-your-mac-keeps-a-log-of-all-your-downloads/"
defaults write com.apple.LaunchServices LSQuarantine -bool NO

printf "%s\n" "Won’t prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false

printf "%s\n" "Will trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

printf "%s\n" "Use AirDrop over every interface. srsly this should be a default"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

###############################################################################
# Kill affected applications                                                  #
###############################################################################

cat << EOF
Done!

################################################################

Note that some of these changes require a logout/restart to take
effect. Killing some open applications in order to take effect.
EOF

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in Finder Dock Mail Safari iTunes iCal Address\ Book SystemUIServer; do
  killall "$app" > /dev/null 2>&1
done
