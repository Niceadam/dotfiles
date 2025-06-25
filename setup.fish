#!/usr/bin/fish

## Base
sudo pacman -Syu
sudo pacman -S --needed base-devel git fish
chsh -s /bin/fish

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

## Packages
# pacman -Qqne > packages.txt
# yay -Qqme >> packages.txt
yay -S (cat packages.txt)

## Bun
curl -fsSL https://bun.sh/install | bash

sudo ufw enable
sudo systemctl enable keyd
sudo systemctl start keyd
rustup default stable

ssh-keygen -t ed25519
refind-install

uv venv ~/.uv-global

## KDE
kwriteconfig6 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true

# Steps:
# - Get Proton Drive files
# - Insert pub.key -> Github, Proxmox...

