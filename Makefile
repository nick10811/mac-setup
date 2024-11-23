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
	brew install wget  # Utility to download files from the web
	brew install nmap  # Network exploration tool and security/port scanner

	# Terminal setup
	@echo "Installing iTerm2..."
	brew install --cask iterm2  # Terminal emulator for macOS
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  # Oh My Zsh framework for managing Zsh configuration
	brew install powerlevel10k  # Theme for Zsh
	echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
	brew install --cask font-meslo-for-powerline  # Font with Powerline symbols
	
	@echo "Installing Oh My Zsh plugins..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting  # Syntax highlighting for Zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions  # Fish-like autosuggestions for Zsh
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions  # Additional completion definitions for Zsh

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
	echo 'syntax on' >> ~/.vimrc  # Enable syntax highlighting in Vim
	echo 'set t_Co=256' >> ~/.vimrc  # Enable 256 colors in Vim
	echo 'set fileencodings=utf-8' >> ~/.vimrc  # Set file encoding to UTF-8 in Vim

	# Aliases
	echo 'alias vsc="code"' >> ~/.zshrc  # Alias for Visual Studio Code
	echo 'alias xcode="open -a Xcode"' >> ~/.zshrc  # Alias to open Xcode
	echo 'alias simulator="open -a Simulator"' >> ~/.zshrc  # Alias to open iOS Simulator
	source ~/.zshrc
.PHONY: setup

configure:
	@echo "\nConfiguring git...\n"

	git config --global user.name $(NAME)  # Set global Git username
	git config --global user.email $(EMAIL)  # Set global Git email
	curl -sL https://www.gitignore.io/api/$(GITIGNORE) -o ~/.gitignore_global  # Download .gitignore template
	git config --global core.excludesfile ~/.gitignore_global  # Set global .gitignore file
.PHONY: configure

install-dev:
	@echo "\nInstalling development tools...\n"

	brew install gitmoji  # Gitmoji CLI for using emojis in commit messages
	brew install --cask fork  # Git GUI client
	brew install --cask visual-studio-code  # Code editor
	brew install --cask docker  # Container platform
	# brew install nvm # Node Version Manager
	# brew install nodejs  # JavaScript runtime
	# python -m pip install --user virtualenv  # Virtual environments for Python

	brew install --cask postman  # API development environment
	# brew install --cask proxyman  # HTTP debugging proxy
.PHONY: install-dev

install-dev-ios:
	@echo "\nInstalling iOS development tools...\n"

	brew install cocoapods  # Dependency manager for Swift and Objective-C
	# sudo gem install cocoapods -v 1.7.1  # Specific version of CocoaPods
	pod setup  # Set up CocoaPods master repo
	brew install carthage  # Dependency manager for Cocoa
	# brew install fastlane  # Automation tool for iOS and Android
	# brew install --cask dash  # API documentation browser
	# brew install --cask android-studio  # Android development environment
.PHONY: install-dev-ios

install-design:
	@echo "\nInstalling design tools...\n"

	brew install --cask figma  # Interface design tool
	brew install --cask zeplin  # Collaboration tool for designers and developers
.PHONY: install-design

install-productivity:
	@echo "\nInstalling productivity tools...\n"

	brew install bat  # A cat clone with syntax highlighting and Git integration
	brew install --cask appcleaner  # Uninstall apps completely
	brew install --cask the-unarchiver  # Archive extraction utility
	brew install --cask eul  # System monitor for Mac
	brew install --cask hiddenbar  # Manage menu bar items on Mac
	brew install --cask time-out  # Break reminder app
	brew install --cask google-chrome  # Web browser
	brew install --cask brave-browser  # Privacy-focused web browser
	brew install --cask notion  # All-in-one workspace for notes, tasks, databases, and more
	# brew install --cask teamviewer  # Remote control and desktop sharing
	# brew install --cask anydesk  # Remote desktop application
	# brew install --cask typora  # Markdown editor
	# brew install --cask macdown  # Markdown editor
.PHONY: install-productivity

install-teamwork:
	@echo "\nInstalling teamwork tools...\n"

	# brew install --cask hamsket-nightly  # Free and open source messaging and emailing app
	brew install --cask zoom  # Video communication tool
	brew install --cask slack  # Collaboration hub for work
	# brew install --cask discord  # Voice, video, and text chat app
	# brew install --cask telegram  # Messaging app with a focus on speed and security
	# brew install --cask skype  # Video and voice call app
	# brew install --cask microsoft-teams  # Collaboration and productivity tool
.PHONY: install-teamwork

install-fun:
	@echo "\nInstalling fun tools...\n"
	
	brew install --cask spotify  # Music streaming service
	# brew install --cask vlc  # Media player
	# brew install --cask tradingview  # Charting and analysis tool for financial markets
.PHONY: install-fun
