## --- Paths and Environment ---
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export EDITOR=nvim

# Android-specific logic isn't needed for these, but good to keep for Linux
if [[ "$OSTYPE" != "linux-android"* ]]; then
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
    export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
fi

## --- Homebrew Auto-Install (Linux Only) ---
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Check if brew is installed, if not, install it
    if ! command -v brew >/dev/null && [ ! -d "/home/linuxbrew/.linuxbrew" ]; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Initialize Brew environment
    if [ -d "/home/linuxbrew/.linuxbrew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
    elif [ -d "$HOME/.linuxbrew" ]; then
        eval "$($HOME/.linuxbrew/bin/brew shellenv zsh)"
    fi
fi

## --- Universal Installer Function ---
# logic: if Android -> use pkg | if Linux -> use brew
install_tool() {
    local tool_exe=$1
    local pkg_name=$2
    if ! command -v "$tool_exe" >/dev/null; then
        echo "$tool_exe not found. Installing $pkg_name..."
        if [[ "$OSTYPE" == "linux-android"* ]]; then
            pkg install "$pkg_name" -y
        else
            brew install "$pkg_name"
        fi
    fi
}

## --- Zinit Setup ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::git
zinit snippet OMZP::podman
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo
zinit snippet OMZP::brew
zinit snippet OMZP::rsync
zinit snippet OMZP::aliases
zinit snippet OMZP::systemd

autoload -Uz compinit && compinit
zinit cdreplay -q

## edit command via neovim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

## --- Tool Initialization & Auto-Install ---
install_tool "oh-my-posh" "oh-my-posh"
eval "$(oh-my-posh init zsh --config "${XDG_CONFIG_HOME:-$HOME/.config}/ohmyposh/amin_catppuccin.toml")"
install_tool "fzf" "fzf"
eval "$(fzf --zsh)"

install_tool "zoxide" "zoxide"
eval "$(zoxide init --cmd cd zsh)"

install_tool "eza" "eza"

install_tool "yazi" "yazi"

## --- History & Styling ---
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:(cd|__zoxide_z):*' fzf-preview 'eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions $realpath'

## --- Aliases ---
alias ls='ls --color'
alias l='ls -lah'
alias els="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias md='mkdir -p'
alias dotfiles="cd ${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles"
alias q='exit'

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases" ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases"
fi

## --- Functions ---
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
