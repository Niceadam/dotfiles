#!/usr/bin/fish

argparse 'i/install' -- $argv
or return

set conf ~/.config

if test -n "$_flag_install"
    echo "Installing configuration..."
    cd configs
    cp -r fish      $conf
    cp -r alacritty $conf
    cp -r nvim      $conf
    cp -r zed       $conf
    cp -r zellij    $conf

    sudo cp -r keyd /etc

    cp .gitconfig   $HOME
    cp .fdignore    $HOME
    cp .ideavimrc   $HOME
else
    echo "Generating configuration..."
    sudo rm -rf           configs/*
    cp -r $conf/fish      configs
    cp -r $conf/alacritty configs
    cp -r $conf/nvim      configs
    cp -r $conf/zed       configs
    cp -r $conf/zellij    configs

    sudo cp -r /etc/keyd  configs

    cp $HOME/.gitconfig   configs
    cp $HOME/.fdignore    configs
    cp $HOME/.ideavimrc   configs

    pacman -Qqne > packages.txt
    yay -Qqme >> packages.txt
end

echo "Done"
