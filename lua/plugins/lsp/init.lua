return {
    --require("plugins/lsp/neodev"),
    require('plugins.lsp.mason'),
    require('plugins.lsp.nvim-lspconfig'),
    require('plugins.lsp.nvim-cmp')
}

--fails to install langauge servers automatically
--
--
--
--requires preinstallations:

--node:
--curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
--source ~/.bashrc  # or source ~/.profile
--
--nvm install --lts
--nvm use --lts
--
--node -v
--npm -v


--python:
--curl https://pyenv.run | bash
--
--export PATH="$HOME/.pyenv/bin:$PATH"
--eval "$(pyenv init --path)"
--
--exec bash
--
--may require build tools:
--sudo apt update
-- sudo apt install -y make build-essential libssl-dev zlib1g-dev \
--     libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
--     libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
--     libffi-dev liblzma-dev pkg-config
--     
--pyenv install 3.12.0
--pyenv global 3.12.0
--
--python --version
--pip --version


--go:
--sudo apt remove --purge golang-go
--
--curl -OL https://go.dev/dl/go1.22.0.linux-arm64.tar.gz
--sudo tar -C /usr/local -xzf go1.22.0.linux-arm64.tar.gz
--
--echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
--source ~/.bashrc
--
--go version


--clangd not yet supported on arm. check for compatability


--must check for unzip tool
--sudo apt install unzip
--unzip -v
