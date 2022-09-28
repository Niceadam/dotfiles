function fish_greeting
    echo 'Welcome back..'
end

function fish_prompt
    printf '[%s] %s%s %s$ ' \
        (date +%H:%M) \
        (set_color $fish_color_cwd) (prompt_pwd) \
        (set_color red)
end

# Exports
set -x EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x FZF_DEFAULT_OPTS "--info=inline"
set -x FZF_DEFAULT_COMMAND "fd --type f --hidden"
set -x ANDROID_HOME "$HOME/.android"
set -x BUN_INSTALL "$HOME/.bun"
set -x PNPM_HOME "$HOME/.local/share/pnpm"

#fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
#fish_add_path $ANDROID_HOME/platform-tools

fish_add_path /opt/cuda/bin
fish_add_path $BUN_INSTALL/bin
fish_add_path $PNPM_HOME
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path (go env GOPATH)/bin
fish_add_path -a $HOME/.foundry/bin

# fzf: search directory from given directory and CD to it, defaults to CWD
function ds --argument-names folder
    if not test -n "$folder"
        set -l folder (pwd)
    end
    set -l folder (fd . $folder --type d --hidden | fzf)
    if test -n "$folder"
        cd $folder
    end
end


# fzf: search file in given directory and opens in Neovim, defaults to CWD
function fs --argument-names folder
    if not test -n "$folder"
        set -l folder (pwd)
    end
    set -l file (fd . $folder --type f --hidden | fzf)
    if test -n "$file"
        nvim $file
    end
end

# Aliases
alias fishconfig "nvim ~/.config/fish/config.fish"
alias sv "sudo -e"

# Git
alias gcd 'cd (git rev-parse --show-toplevel)'
alias ga 'git add'
alias gc 'git commit'
alias gca 'git commit --amend'
alias gp 'git push --force-with-lease'
alias gst 'git status'
alias gch 'git checkout'
alias gbr 'git branch'
alias gdf 'git diff'
alias glg "\
git log --graph --abbrev-commit --decorate \
--format=format:'%C(bold blue)%h%C(reset) - \
%C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) \
%C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' -12"

# ls
alias ls 'eza -1s type'
alias la 'eza -1as type'
alias ll 'eza -ls type --git'
alias tree 'eza --tree'
alias rmd 'sudo rm -rfd'

# pacman
alias pi 'yay -S'
alias pu 'yay -Syu'
alias pr 'yay -Rs'
alias pss 'yay -Ss'

# LUKS
alias cryptmount 'sudo cryptsetup luksOpen /dev/sda nicedrive && sudo mount /dev/mapper/nicedrive /mnt'
alias cryptunmount 'sudo umount /mnt && sudo cryptsetup luksClose nicedrive'

# Intellij
alias idea 'fish -c "~/theca/intellij/bin/idea &>/dev/null 2>&1 &"'

###########################

function f --wraps nnn --description 'support nnn quit and change directory'
    # Block nesting of nnn in subshells
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo "nnn is already running"
        return
    end

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "-x" from both lines below,
    # without changing the paths.
    set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"

    # The command function allows one to alias this function to `nnn` without
    # making an infinitely recursive alias
    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
end
