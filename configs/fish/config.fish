function fish_greeting
    echo 'Welcome back, Niceadam'
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
set -x ANDROID_HOME "/home/niceadam/.android"

fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path $ANDROID_HOME/platform-tools

fish_add_path $HOME/.cargo/bin
fish_add_path (go env GOPATH)/bin

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

# tmux: open new session from current directory
function sesh
    set -l base (basename $PWD)
    if not tmux has-session -t=$base 2>/dev/null
        tmux new -ds $base -c $PWD
    end
    tmux switch-client -t $base
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
alias gbr 'git branch'
alias gdf 'git diff'
alias glg "\
git log --graph --abbrev-commit --decorate \
--format=format:'%C(bold blue)%h%C(reset) - \
%C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) \
%C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"

# ls
alias ls 'exa -1s type'
alias la 'exa -1as type'
alias ll 'exa -ls type --git'
alias tree 'exa --tree'
alias rmd 'sudo rm -rfd'

# pacman
alias pi 'yay -S'
alias pu 'yay -Syu'
alias pr 'yay -Rs'
alias pss 'yay -Ss'

alias nicemox "open https://localhost:8006 && ssh -L 8006:localhost:8006 nicemox"

function sshmox --argument-names remote
  ssh debian@"$remote" -J homemox
end

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
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command function allows one to alias this function to `nnn` without
    # making an infinitely recursive alias
    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/niceadam/miniconda3/bin/conda
    eval /home/niceadam/miniconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<

# pnpm
set -gx PNPM_HOME "/home/niceadam/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $PATH $BUN_INSTALL/bin

# fnm
set -gx PATH "/run/user/1000/fnm_multishells/234042_1715254016261/bin" $PATH;
set -gx FNM_COREPACK_ENABLED "false";
set -gx FNM_MULTISHELL_PATH "/run/user/1000/fnm_multishells/234042_1715254016261";
set -gx FNM_LOGLEVEL "info";
set -gx FNM_RESOLVE_ENGINES "false";
set -gx FNM_ARCH "x64";
set -gx FNM_DIR "/home/niceadam/.local/share/fnm";
set -gx FNM_VERSION_FILE_STRATEGY "local";
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
