#!/usr/bin/fish

set conf ~/.config
set generate_or_install true

if $generate_or_install
    ### Generate Configuration
    sudo rm -rf            configs/*
    cp -r $conf/fish       configs
    cp -r $conf/alacritty  configs
    cp -r $conf/nvim       configs
    cp $HOME/.gitconfig    configs
    cp $HOME/.tmux.conf    configs
    cp $HOME/.zshrc        configs
    cp $HOME/.fdignore     configs
    cp $HOME/.ideavimrc    configs
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
    cp .ideavimrc          $HOME
    sudo cp -r keyd        /etc
    echo "Insertion done."
end
