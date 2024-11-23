NAME = "Your Name"
EMAIL = "your@email.com"
GITIGNORE = "linux,swift,xcode,macos,objective-c,visualstudiocode"

# INTEL_FLAGS = ""
# ifneq ($(filter arm%,$(shell uname -p)),)
# 	INTEL_FLAG = "arch -x86_64"
# endif

all: setup configure install-dev install-dev-ios install-design install-productivity install-teamwork install-fun
.PHONY: all

setup:
	@echo "\nSetting up...\n"

	@echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install wget
	brew install nmap

	# Terminal setup
	@echo "Installing iTerm2..."
	brew install --cask iterm2
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	brew install powerlevel10k
	echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
	brew install --cask font-meslo-for-powerline
	
	@echo "Installing Oh My Zsh plugins..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

	PLUGINS = zsh-syntax-highlighting zsh-autosuggestions zsh-completions
	@echo "Updating .zshrc with new plugins..."
	for plugin in $(PLUGINS); do \
		if ! grep -q "$$plugin" ~/.zshrc; then \
			sed -i '' "/^plugins=/ s/)/ $$plugin)/" ~/.zshrc; \
		fi; \
	done
	source ~/.zshrc
	@echo ".zshrc updated."

	# Vim setup
	echo 'syntax on' >> ~/.vimrc
	echo 'set t_Co=256' >> ~/.vimrc
	echo 'set fileencodings=utf-8' >> ~/.vimrc

	# Aliases
	echo 'alias vsc="code"' >> ~/.zshrc
	echo 'alias xcode="open -a Xcode"' >> ~/.zshrc
	echo 'alias simulator="open -a Simulator"' >> ~/.zshrc
	source ~/.zshrc
.PHONY: setup

configure:
	@echo "\nConfiguring git...\n"

	git config --global user.name $(NAME)
	git config --global user.email $(EMAIL)
	curl -sL https://www.gitignore.io/api/$(GITIGNORE) -o ~/.gitignore_global
	git config --global core.excludesfile ~/.gitignore_global
.PHONY: configure

install-dev:
	@echo "\nInstalling development tools...\n"

	# brew install gitmoji
	brew install --cask fork
	brew install --cask visual-studio-code
	brew install --cask docker
	# brew install nvm # Node Version Manager
	# brew install nodejs
	# python -m pip install --user virtualenv

	brew install --cask postman
	# brew install --cask proxyman
.PHONY: install-dev

install-dev-ios:
	@echo "\nInstalling iOS development tools...\n"

	brew install cocoapods
	# sudo gem install cocoapods -v 1.7.1
	pod setup
	brew install carthage
	# brew install fastlane

	# brew install --cask dash
	# brew install --cask android-studio
.PHONY: install-dev-ios

install-design:
	@echo "\nInstalling design tools...\n"

	brew install --cask figma
	brew install --cask zeplin
.PHONY: install-design

install-productivity:
	@echo "\nInstalling productivity tools...\n"

	brew install bat # custom cat
	brew install --cask appcleaner
	brew install --cask the-unarchiver
	brew install --cask eul
	brew install --cask hiddenbar
	brew install --cask time-out
	brew install --cask google-chrome
	brew install --cask brave-browser
	brew install --cask notion
	# brew install --cask teamviewer
	# brew install --cask anydesk
	# brew install --cask typora
	# brew install --cask macdown
.PHONY: install-productivity

install-teamwork:
	@echo "\nInstalling teamwork tools...\n"

	# brew install --cask hamsket-nightly
	brew install --cask zoom
	brew install --cask slack
	# brew install --cask discord
	# brew install --cask telegram
	# brew install --cask skype
	# brew install --cask microsoft-teams
.PHONY: install-teamwork

install-fun:
	@echo "\nInstalling fun tools...\n"
	
	brew install --cask spotify
	# brew install --cask vlc
	# brew install --cask tradingview
.PHONY: install-fun
