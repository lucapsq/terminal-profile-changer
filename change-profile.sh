#!/bin/bash

# Name of the profile to use
profile='Frappe'


# Check if system theme is dark
if [ "$(defaults read -g AppleInterfaceStyle)" == "Dark" ]; then
    # If dark, use dark profile
profile='Latte'
fi

# Set the default profile
defaults write com.apple.Terminal "Default Window Settings" -string "$profile"
defaults write com.apple.Terminal "Startup Window Settings" -string "$profile"

# Set the current profile
osascript <<EOF
if application "Terminal" is running then
    tell application "Terminal"
        set current settings of tabs of windows to settings set "$profile"
    end tell
end if
EOF




