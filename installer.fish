#!/usr/bin/fish

## Base
sudo pacman -Syu
sudo pacman -S --needed base-devel git

## Konsole Theme
cd /usr/share/konsole
sudo git clone https://github.com/cskeeters/base16-konsole.git
sudo mv ./base16-konsole/colorscheme/*.colorscheme .
cd

## Packages
sudo pacman -S --needed \
cmake cmatrix dolphin exa fish gnome-keyring \
gparted konsole neofetch neovim okular tlp vlc qbittorrent tldr \
grub-customizer

yay -S nerd-fonts-source-code-pro
yay -S keyd-git nnn-nerd miniconda3 visual-studio-code-bin

## Miniconda
conda init
conda config --add channels conda-forge
conda config --set channel_priority strict
conda update --all
conda create -n main-env tqdm numpy scipy matplotlib requests
