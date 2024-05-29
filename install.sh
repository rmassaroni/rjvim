#!/bin/bash
dir="$HOME/.config/nvim"

if command -v nvim &> /dev/null
then
    echo "Neovim is already installed."
else
    echo "Neovim is not installed. Installing Neovim with Homebrew..."
    if command -v brew &> /dev/null
    then
        echo "Homebrew is already installed."
    else
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        #if [ -d "/home/linuxbrew/.linuxbrew/Cellar" ]; then
            #sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew/Cellar
            sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew/var/homebrew
            sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew/Cellar

            /home/linuxbrew/.linuxbrew/bin/brew update --force --quiet
        #fi
        #echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        #eval "$(/opt/homebrew/bin/brew shellenv)"
        #echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
        #eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


    fi
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$(whoami)/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    source ~/.bashrc
    brew install neovim
fi

if [ ! -d "$dir" ]; then
    echo "~/.config/nvim not found. Cloning repository..."
    git clone https://github.com/rmassaroni/rjvim.git "$dir"
fi

echo Done

