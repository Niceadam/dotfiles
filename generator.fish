#!/usr/bin/fish

# Get list of installed packages
#yay -Qqe > packages.txt

set conf ~/.config
set generate_or_install true

if $generate_or_install
    ### Generate Configuration
    sudo rm -rf            configs/*
    cp -r $conf/fish       configs
    cp -r $conf/alacritty  configs
    cp -r $conf/nvim       configs
    cp ~/.gitconfig        configs
    cp ~/.tmux.conf        configs
    cp ~/.zshrc            configs
    cp ~/.fdignore         configs
    sudo cp -r /etc/keyd   configs
    echo "Generation done."
else
    ### Install Configurationn
    cd configs
    cp -r fish             $conf
    cp -r alacritty        $conf
    cp -r nvim             $conf
    cp .gitconfig          $HOME
    cp .tmux.conf          $HOME
    cp .zshrc              $HOME
    cp .fdignore           $HOME
    sudo cp -r keyd        /etc
    echo "Insertion done."
end

