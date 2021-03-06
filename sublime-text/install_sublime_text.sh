#!/bin/sh

# Sublime Text 3 install with Package Control (last update: 25 August 2016)
#
# No need to download this script, just run it on your terminal:
#
#  $  curl -L git.io/sublimetext | sh
#
# When you need to update Sublime Text, run this script again.

# Sudo
sudo -v

# Detect the architecture
if [ "$(uname -m)" = "x86_64" ]; then
  ARCHITECTURE="x64"
else
  ARCHITECTURE="x32"
fi

# Fetch the latest build version number (thanks daveol)
BUILD=$(echo $(curl http://www.sublimetext.com/3) | sed -rn "s#.*The latest build is ([0-9]+)..*#\1#p")

URL="https://download.sublimetext.com/sublime_text_3_build_{$BUILD}_{$ARCHITECTURE}.tar.bz2"
INSTALLATION_DIR="/opt/sublime_text"

# Download the tarball, unpack and install
curl -o $HOME/st3.tar.bz2 $URL
if tar -xf $HOME/st3.tar.bz2 --directory=$HOME; then
  # Remove the installation folder and the symlink, they might already exist
  sudo rm -rf $INSTALLATION_DIR /bin/subl
  sudo mv $HOME/sublime_text_3 $INSTALLATION_DIR
  sudo ln -s $INSTALLATION_DIR/sublime_text /bin/subl
fi
rm $HOME/st3.tar.bz2


# Package Control - The Sublime Text Package Manager: https://packagecontrol.io
mkdir -p $HOME/.config/sublime-text-3/Installed\ Packages
curl -o $HOME/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package https://packagecontrol.io/Package%20Control.sublime-package

# Add to applications list (thanks 4ndrej)
sudo ln -s $INSTALLATION_DIR/sublime_text.desktop /usr/share/applications/sublime_text.desktop

# Set the icon (thanks gcaracuel)
sudo sed -i.bak 's/Icon=sublime-text/Icon=\/opt\/sublime_text\/Icon\/128x128\/sublime-text.png/g' /usr/share/applications/sublime_text.desktop

echo '
Sublime Text 3 installed successfully!
Run with: subl
'