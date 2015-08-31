###############################################################################
# Security settings, see https://github.com/drduh/OS-X-Yosemite-Security-and-Privacy-Guide
###############################################################################

if [ "$USER" = "kfinlay" ]
then
    echo "Enabling FileVault 2"
    sudo fdesetup enable
    echo ""
    echo "Enabling Application Level Firewall
    sudo defaults write /Library/Preferences/com.apple.alf \ globalstate -int 1
    sudo defaults write /Library/Preferences/com.apple.alf \ allowsignedenabled -bool false
    sudo defaults write /Library/Preferences/com.apple.alf \ loggingenabled -bool true
    sudo defaults write /Library/Preferences/com.apple.alf \ stealthenabled -bool true
    echo ""
    echo "Privacy settings for OS X"
    curl -O https://fix-macosx.com/fix-macosx.py && /usr/bin/python fix-macosx.py
    
fi

exit 0
