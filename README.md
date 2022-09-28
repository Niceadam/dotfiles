# Dotfiles

## Setup

### Base

```
sudo pacman -Syu
sudo pacman -S --needed base-devel git fish
chsh -s /bin/fish

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Packages

```
yay -S (cat packages.txt)
curl -fsSL https://bun.sh/install | bash
```

### Config

```
sudo ufw enable
sudo systemctl enable keyd
sudo systemctl start keyd
rustup default stable

ssh-keygen -t ed25519
refind-install

kwriteconfig6 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true
```

### Proton: Obsidian Notes
```
mkdir -p ~/obsidian
rclone config
rclone sync proton:obsidian/ ~/obsidian --progress (--dry-run)
```

### Extra
- Insert pub.key -> Github, Proxmox...
- Firefox accounts (Recovery Codes)
- `kubectl` clusters

### Home
```
├── ardour
│   ├─ impulses
│   ├─ neural
│   └─ project
├── books
├── code
│   ├─ hacking
│   ├─ projects
│   ├─ theca
│   └─ uv
├── dotfiles
├── downloads
└── obsidian
```
