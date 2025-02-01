#!/usr/bin/fish

## Base
sudo pacman -Syu
sudo pacman -S --needed base-devel git
chsh -s /bin/fish

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

## Packages
yay -S \
  age\
  alacritty\
  asciiquarium\
  base-devel\
  cmatrix\
  cuda\
  curl\
  docker-compose\
  docker\
  eza\
  fd\
  firefox\
  firefox-developer-edition\
  fish\
  fzf\
  git\
  gnome-disk-utility\
  go\
  gparted\
  htop\
  inkscape\
  jdk-openjdk\
  keyd\
  neofetch\
  neovim\
  nmap\
  nnn-nerd\
  nvidia-open\
  nvidia-utilities\
  okular\
  pnpm\
  qbittorrent\
  refind\
  ripgrep\
  rustup\
  tldr\
  tor\
  torbrowser-launcher\
  ttf-iosevka-nerd\
  ufw\
  unzip\
  visual-studio-code-bin\
  vlc\
  wayclip\
  wget\
  wmctrl\
  yubico-authenticator-bin\
  zellij

sudo ufw enable
sudo systemctl enable keyd
sudo systemctl start keyd
rustup default stable
yay -S kdotool-git brave-bin

ssh-keygen -t ed25519
# Change SSH keys in Github, Proxmox...

refind-install

# Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda.sh
chmod +x conda.sh
./conda.sh

# Bun
curl -fsSL https://bun.sh/install | bash

# Settings:
# Set Locations
# Downloads -> downloads ...
# Alt+F -> /etc/keyd/open.sh firefox
# Alt+Q -> /etc/keyd/open.sh alacritty
# Icons: Tela manjoro dark
# Night Light
# Insert pub.key -> Github
