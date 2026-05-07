#!/bin/bash

# Define colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting dotfiles installation...${NC}"

# 1. Identify Environment
OS_TYPE=$(uname -o)
IS_ANDROID=false
if [[ "$OS_TYPE" == *"Android"* ]]; then
    IS_ANDROID=true
    echo -e "${BLUE}Detected Android (Termux) environment.${NC}"
fi

# 2. Install Git & Basic Build Tools
echo -e "${BLUE}Ensuring Git is installed...${NC}"
if $IS_ANDROID; then
    pkg update && pkg install -y git binutils coreutils
else
    # For Linux (Ubuntu/Debian/Fedora)
    if command -v apt >/dev/null; then
        sudo apt update && sudo apt install -y git build-essential
    elif command -v dnf >/dev/null; then
        sudo dnf install -y git @development-tools
    fi
fi

# 3. Clone / Update Dotfiles Repo
DOTFILES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles"
TARGET_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
REPO_URL="https://github.com/AminGholizad/dotfiles.git"

if [ ! -d "$DOTFILES_DIR" ]; then
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    echo -e "${BLUE}Cloning dotfiles to $DOTFILES_DIR...${NC}"
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    echo -e "${BLUE}Dotfiles directory exists, pulling latest changes...${NC}"
    cd "$DOTFILES_DIR" && git pull
fi

# 4. Bootstrap Homebrew (Linux only)
if ! $IS_ANDROID; then
    if ! command -v brew >/dev/null; then
        echo -e "${BLUE}Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Temporary path for the rest of this script
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

# 5. Install apps
if ! $IS_ANDROID; then
    brew install git zsh stow tmux nvim
else
    pkg install zsh stow tmux nvim
fi
# 6. Symbolic Linking
echo -e "${BLUE}Linking configuration files...${NC}"
stow -v --adopt -d "$DOTFILES_DIR" -t "$HOME" zsh
mkdir -p "$TARGET_CONFIG"/{nvim,tmux,ohmyposh}
stow -v --adopt -d "$DOTFILES_DIR" -t "$TARGET_CONFIG/nvim" nvim
stow -v --adopt -d "$DOTFILES_DIR" -t "$TARGET_CONFIG/tmux" tmux
stow -v --adopt -d "$DOTFILES_DIR" -t "$TARGET_CONFIG/ohmyposh" ohmyposh

# 7. Change Default Shell to ZSH
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo -e "${BLUE}Changing default shell to zsh...${NC}"
    if $IS_ANDROID; then
        # Termux version
        chsh -s zsh
    else
        # Linux version - requires password
        sudo chsh -s "$(command -v zsh)" "$USER"
    fi
    echo -e "${GREEN}Installation finished. Switching to zsh now...${NC}"
    exec zsh -l
else
    echo -e "${BLUE}ZSH is already the default shell.${NC}"
    echo -e "${GREEN}Installation finished.${NC}"
fi
