#!/usr/bin/fish

set conf ~/.config
set generate_or_install true

if $generate_or_install
    ### Generate Configuration
    sudo rm -rf           configs/*
    cp -r $conf/fish      configs
    cp -r $conf/alacritty configs
    cp -r $conf/nvim      configs
    cp -r $conf/zellij    configs
    cp $HOME/.gitconfig   configs
    cp $HOME/.fdignore    configs
    cp $HOME/.ideavimrc   configs
    sudo cp -r /etc/keyd  configs
    echo "Generation done."
else
    ### Install Configurationn
    cd configs
    cp -r fish      $conf
    cp -r alacritty $conf
    cp -r nvim      $conf
    cp -r zellij    $conf
    cp .gitconfig   $HOME
    cp .fdignore    $HOME
    cp .ideavimrc   $HOME
    sudo cp -r keyd /etc
    echo "Insertion done."
end
