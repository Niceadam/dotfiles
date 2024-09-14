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
 alacritty\
 base-devel\
 cmatrix\
 cuda\
 curl\
 docker\
 docker-compose\
 exa\
 fd\
 firefox\
 fish\
 fzf\
 git\
 go\
 gparted\
 htop\
 inkscape\
 jdk-openjdk\
 keyd\
 neofetch\
 neovim\
 nnn-nerd\
 npm\
 okular\
 qbittorrent\
 refind\
 ripgrep\
 rustup\
 tailscale\
 tldr\
 tmux\
 ttf-iosevka-nerd\
 vim\
 visual-studio-code-bin\
 vlc\
 wget\
 wmctrl\
 ufw\
 unzip\
 wayclip

curl -fsSL https://get.pnpm.io/install.sh | sh -
sudo ufw enable
sudo systemctl enable keyd
sudo systemctl start keyd
rustup default stable
yay -S kdotool-git
ssh-keygen
refind-install

# Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O conda.sh
chmod +x conda.sh
./conda.sh

# Settings:
# Set Locations
# Downloads -> downloads ...
# Alt+F -> /etc/keyd/open.sh firefox
# Alt+Q -> /etc/keyd/open.sh alacritty
# Icons: Tela manjoro dark
# Night Light
# Insert pub.key -> Github
