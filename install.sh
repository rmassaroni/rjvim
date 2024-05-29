#!/bin/bash
dir="$HOME/.config/nvim"

if [ ! -d "$dir" ]; then
    echo "~/.config/nvim not found. Cloning repository..."
    git clone https://github.com/rmassaroni/rjvim.git "$dir"
fi

