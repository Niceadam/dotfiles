zstyle ':znap:*' repos-dir ~/.oh-my-zsh/plugins
source ~/git-down/zsh-snap/znap.zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)
source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env

### WORK -----------------
source /usr/share/oe-setup/oe-setup.sh > /dev/null
printf "\033[1;32m[Axis New Terminal]\033[0m\n"
export CAM="192.168.0"
export eth=enp3s0

alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gp='git push origin HEAD:refs/for/master%wip'
alias gbr='git branch'
alias gst='git status'
alias gch='git checkout'
alias gdf='git diff'
alias glg='git log --graph'
alias gall='gitk --all &'

alias gitdir='git rev-parse --show-toplevel'
alias gitbase='basename $(gitdir)'
alias gcd='cd $(gitdir)'

alias ff='ffbuild'
alias ffb='ff $(gitbase)'
alias ffc='ff --check $(gitbase)-unittest'
alias ffm='ff --checkmem $(gitbase)-unittest'
alias ffst='ff --devstatus'
alias ffclean='ff --clean $(gitbase)'
alias ffreset='ff --reset $(gitbase)'
alias ffd='ff $(gitbase) --deploy'

alias rundone='notify-send 'Terminal: Task Done' -t 30000 | at now'
alias dirfmt='fd --extension h --extension c --exec clang-format --style=file -i'
alias python='python3'

ffmod() {
  if [[ -v 1 ]]; then
    ffbuild --modify $1 --mdir $1
  fi
}

# cd to nearest machine dir, oe-initenv, and cd back
ienv() {
  current=$PWD
  machine=$(pwd | grep -oE '.*/builds/[^/]*')
  cd $machine
  oe-initenv
  cd $current
}

# Lists cameras on network
cams() {
  if [[ ! -v 1 ]]; then
    xcam-scan -bn $eth
  else
    out=$(xcam-scan -bn $eth | grep -oE "192.168.0.$1")
    if [[ $out ]]; then
      xdg-open 'http://'$out'/aca/index.html#settings/system'
    else
      echo "Invalid argument."
    fi
  fi
}

# Given camera [IP], enable and enter camera's SSH
#
# If length([IP]) > 3, then use as external IP.
# Don't forget to set camera password on startup beforehand!
shcam() {
  if [[ ! -v 1 ]]; then
    echo "No argument"
    return 1
  fi

  if [[ ${#1} -gt 3 ]]; then
    out=$1
  else
    out=192.168.0.$1
  fi

  http -A digest -a root:pass 'http://'$out'/axis-cgi/param.cgi?action=update&root.Network.SSH.Enabled=yes' > /dev/null
  ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$out" > /dev/null
  sshpass -p pass ssh -o StrictHostKeyChecking=no root@$out
}

bearbake() {
  cd $(git rev-parse --show-toplevel)
  PACKAGE=$(basename $(pwd))
  rm -f compile_commands.json

  echo "Generating compile database for $PACKAGE:"
  echo "Cleaning..."
  ffbuild --clean $PACKAGE > /dev/null 

  echo "Running Bear & ffbuild..."
  bear -- ffbuild $PACKAGE > /dev/null
  echo "Success!"
}

# ------------------------

# fzf: search directory from given directory and CD to it, defaults to HOME
ds() {
    if [[ ! -v 1 ]]; then
        1=$HOME
    fi
    folder=$(fd . $1 --type d --hidden | fzf)
    if [[ $folder ]]; then
        cd $folder
    fi
}

# fzf: search file in given directory and opens in Neovim, defaults to HOME
fs() {
    if [[ ! -v 1 ]]; then
        1=$HOME
    fi
    file=$(fd . $1 --type f --hidden | fzf)
    if [[ $file ]]; then
        nvim $file
    fi
}

# tmux: open new session from current directory
sesh() {
    base=$(basename $PWD)
    if ! tmux has-session -t=$base 2>/dev/null; then
        tmux new -ds $base -c $PWD
    fi
    tmux switch-client -t $base
}

# Exports
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export PROMPT="[%T] %(?:%{%}➜ :%{%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info) \$ "
export FZF_DEFAULT_OPTS="--info=inline"
export FZF_DEFAULT_COMMAND="fd --type f --hidden"

export camera_exceptions="$(seq -s ',' -f '192.168.0.%g' 1 255)"
export no_proxy="127.0.0.1,localhost,$camera_exceptions"
export NO_PROXY=$no_proxy
export http_proxy="http://wwwproxy:3128"
export https_proxy=$http_proxy
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export ftp_proxy=$http_proxy
export GRADLE_OPTS="-Dhttps.proxyHost=wwwproxy -Dhttps.proxyPort=3128\
                    -Dhttp.proxyHost=wwwproxy -Dhttp.proxyPort=3128"

plugins=(zsh-autosuggestions history-substring-search, zsh-syntax-highlighting) 

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias v="nvim"
alias sv="sudo -e"
alias notify='notify-send "Terminal Task" "Done." -t 0'

alias ls='exa -1s type'
alias la='exa -1as type'
alias ll='exa -ls type --git'
alias tree='exa --tree'
alias rmd='sudo rm -rfd'

alias pi='sudo apt-get install'
alias pu='sudo apt-get update && sudo apt-get upgrade'
alias pr='sudo apt-get purge'
alias pss='sudo apt-cache search'

alarm() {
  echo "notify-send '$1'" | at $2
}

f() {
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

[ -f "/home/adama/.ghcup/env" ] && source "/home/adama/.ghcup/env" # ghcup-env
