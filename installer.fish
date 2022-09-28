#!/usr/bin/fish

## Base
sudo pacman -Syu
sudo pacman -S --needed base-devel git yay

## Packages
yay -S (cat arch-pkgs.txt)

## Miniconda
conda init
conda config --add channels conda-forge
conda config --set channel_priority strict
conda update --all
conda create -n main-env tqdm numpy scipy matplotlib requests
