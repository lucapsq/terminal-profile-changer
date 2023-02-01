#!/bin/bash


cd dark-mode-notify
sudo make install

echo -n "Enter light profile name:"
read lightProfileName

echo -n "Enter dark profile name:"
read darkProfileName

cd ..

plist="<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE plist PUBLIC '-//Apple//DTD PLIST 1.0//EN'
'http://www.apple.com/DTDs/PropertyList-1.0.dtd'>
<plist version='1.0'>
<dict>
    <key>Label</key>
    <string>com.lucapsq.change-profile</string>
    <key>KeepAlive</key>
    <true/>
    <key>ProgramArguments</key>
    <array>
       <string>/usr/local/bin/dark-mode-notify</string>
       <string>/Users/$USER/Library/LaunchAgents/change-profile.sh</string>
    </array>
</dict>
</plist>"


touch "com.lucapsq.change-profile.plist"
echo "Creating plist file..."
echo "$plist" > "com.lucapsq.change-profile.plist"



sed "4s/.*/profile='$lightProfileName'/" change-profile.sh > change-profile.tmp && mv change-profile.tmp change-profile.sh
sed "10s/.*/profile='$darkProfileName'/" change-profile.sh > change-profile.tmp && mv change-profile.tmp change-profile.sh



launchAgentsDir="/Users/$USER/Library/LaunchAgents/"

sudo chmod +x "com.lucapsq.change-profile.plist" "change-profile.sh"

sudo cp com.lucapsq.change-profile.plist change-profile.sh "$launchAgentsDir"


launchctl load -w ~/Library/LaunchAgents/com.lucapsq.change-profile.plist

echo "Done."
