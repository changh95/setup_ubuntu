#!/bin/bash 

# Update system
sudo apt-get -y update
sudo apt-get -y upgrade

# Install programs
sudo apt-get -y install ubuntu-unity-desktop # Ubuntu renderer
sudo snap install clion --classic # CLion IDE
sudo snap install pycharm-community --classic # Pycharm Community IDE
sudo snap install --classic code # Visual studio code
sudo snap install ao # Microsoft Todo
sudo snap install slack --classic # Slack
sudo snap install teams # Microsoft Teams
sudo snap install notion-snap # Notion
sudo apt-get -y install kolourpaint # kolourpaint
sudo apt-get -y install peek # peek

wget -nc https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb # Google Chrome
sudo apt -y install ./google-chrome-stable_current_amd64.deb
sudo rm -rf ./google-chrome-stable_current_amd64.deb

wget -nc https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt -y install ./teamviewer_amd64.deb
sudo rm -rf ./teamviewer_amd64.deb

# Install essentials
sudo apt-get -y install build-essential cmake git wget curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev

# Python
sudo apt-get -y install python3 python3-pip

# Golang
snap install --classic go

# Terminal
sudo apt-get -y install zsh # zsh
echo "(setup_ubuntu.sh) : Setup zsh, and exit!"
zsh

sudo rm -rf ${ZDOTDIR:-$HOME}/.zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" # prezto
echo "" >> ~/.zshrc
echo "# prezto\n" >> ~/.zshrc
echo "setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done" >> ~/.zshrc
chsh -s /bin/zsh

sudo apt-get -y install tmux # tmux

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable

# C++
sudo apt-get -y install cmake ninja-build

# Terminal App (Alacritty)
git clone https://github.com/alacritty/alacritty.git # Alacritty
cd alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Docker
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt-get -y install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER

# GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get -y update
sudo apt-get -y install gh

# Finished
echo "Now reboot system to apply changes"
