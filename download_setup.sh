#!/usr/bin/env bash

# This file will download all the applications needed for this dev setup.
# You should first download WSL and powertoys in the windows shell.
# Additionally, download windows terminal from the Microsoft Store or
# the Microsoft website.
#
# wsl.exe --install
#
# winget install --id Microsoft.PowerToys --source winget

BASHRC="$HOME/.bashrc"
CONFIG_DIR="$HOME/.config"
NVIM_DIR="$CONFIG_DIR/nvim"
NVM_DIR="$HOME/.nvm"
TMUX_PLUGIN_DIR="$HOME/.tmux/plugins/tpm"
CONDA_PREFIX="$HOME/miniconda3"
GO_VERSION="1.24.2"
LAZYGIT_VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
	| grep -oP '"tag_name": *"v\K[^"]*')

# 1. Update WSL & Script Setup
# Safety Flags
set -euo pipefail
IFS=$'\n\t'

# Update WSL
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install build-essential git curl wget unzip \
	ca-certificates -y

# 2. Download repo
mkdir -p "$NVIM_DIR"
if [ ! -d "$NVIM_DIR/.git" ]; then
	git clone https://github.com/mingra02/nvim_config "$NVIM_DIR"
	(cd "$NVIM_DIR" && git switch master)
fi

cd ~

# 3. Install Node JS and NPM
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
	source "$NVM_DIR/nvm.sh"
	nvm install --lts
	nvm alias default lts/*
fi

grep -qF 'nvm.sh' ~/.bashrc || \
	printf '\nexport NVM_DIR="$HOME/.nvm"\n[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"\n' >> ~/.bashrc

# 4. Install Docker

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
	sudo apt remove -y "$pkg" || true
done

sudo install -m0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
	sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
	https://download.docker.com/linux/ubuntu \
	$(. /etc/os-release && echo $VERSION_CODENAME) stable" \
	| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io \
	docker-buildx-plugin docker-compose-plugin -y

if ! getent group docker >/dev/null; then
	sudo groupadd docker
fi

sudo usermod -aG docker $USER

# 5. Install TMUX

sudo apt install tmux -y
if [ ! -d "$TMUX_PLUGIN_DIR" ]; then
	git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR"
fi
cp -n ~/.config/nvim/tmux.conf ~/.tmux.conf

# IMPORTANT, to download and install plugins, run the following command
# inside tmux:
# control + b then I

# 6. Install miniconda
if [ ! -d "$CONDA_PREFIX" ]; then
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -qO ~/miniconda.sh
	bash ~/miniconda.sh -b -p "$CONDA_PREFIX"
	rm ~/miniconda.sh

	"$CONDA_PREFIX/bin/conda" init bash
fi

# 7. Install GO
if ! go version &>/dev/null; then
	curl -fsSL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -o ~/go.tar.gz
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf ~/go.tar.gz
	rm go.tar.gz

	echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi

#8 Install Lazygit and Lazydocker
# Lazygit
curl -fsSL \
	"https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
	-o ~/lazygit.tar.gz
tar xzf ~/lazygit.tar.gz lazygit && rm ~/lazygit.tar.gz
sudo install lazygit -D -t /usr/local/bin/
rm  lazygit

# Lazydocker
go install github.com/jesseduffield/lazydocker@latest


# 9. Install Oh My Posh
if ! command -v oh-my-posh >/dev/null; then
	curl -fsSL https://ohmyposh.dev/install.sh | bash
fi

# 10. Install NVIM
if ! command -v nvim >/dev/null; then
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt update
	sudo apt install neovim -y
fi

# Finally, Update ~/.bashrc and resource

append_if_missing() {
	grep -Fqx "$1" "$BASHRC" || echo "$1" >> "$BASHRC"
}

append_if_missing 'export PATH=$PATH:/opt/nvim/bin'
append_if_missing 'export PATH=$PATH:$HOME/.tmux/plugins/tmuxifier/bin'
append_if_missing 'export PATH=$PATH:/usr/local/go/bin'
append_if_missing 'export PATH=$PATH:$(go env GOPATH)/bin'
append_if_missing 'export NVM_DIR="$HOME/.nvm"'
append_if_missing '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
append_if_missing 'eval "$(oh-my-posh init bash --config ~/nvim_config/posh.json)"'

source "$BASHRC"

# TODO: ##################################################################
# 1. Install nerdfonts: https://www.nerdfonts.com/font-downloads (Hack Ned Font is a good choice)
# 2. Windows Terminal: Set font, font size 10 is good, One Half Dark theme
# 3. Install tmux plugins with control + b then I
