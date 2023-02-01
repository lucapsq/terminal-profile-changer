#!/bin/bash

repo_url="https://github.com/bouk/dark-mode-notify"

echo "Cloning repository from $repo_url"
git clone $repo_url
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
       <string>/Users/$USER/Library/LaunchAgents/change_theme.sh</string>
    </array>
</dict>
</plist>"


touch "com.lucapsq.change-profile.plist"
echo "Creating plist file..."
echo "$plist" > "com.lucapsq.change-profile.plist"



sed "4s/.*/profile='$lightProfileName'/" esempio.sh > esempio.tmp && mv esempio.tmp esempio.sh
sed "10s/.*/profile='$darkProfileName'/" esempio.sh > esempio.tmp && mv esempio.tmp esempio.sh


echo "Done."
