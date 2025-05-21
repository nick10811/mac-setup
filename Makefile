include config.mk

# INTEL_FLAGS = ""
# ifneq ($(filter arm%,$(shell uname -p)),)
# 	INTEL_FLAG = "arch -x86_64"
# endif

all: setup configure install-dev install-dev-ios install-design install-productivity install-teamwork install-fun
.PHONY: all

# apps: install software only, without writing any config files (~/.zshrc, ~/.vimrc, etc.)
# Intended to be called by dotfiles/install.sh so symlinks take precedence over config.
apps: _brew _shell-tools install-dev install-dev-ios install-design install-productivity install-teamwork install-fun
.PHONY: apps

_brew:
	@echo "\nInstalling Homebrew..."
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
.PHONY: _brew

_shell-tools:
	@echo "\nInstalling apps from Brewfile..."
	brew bundle

	@echo "Installing Oh My Zsh..."
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	@echo "Installing Oh My Zsh plugins..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k || true
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
	git clone https://github.com/zsh-users/zsh-completions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions || true
.PHONY: _shell-tools

setup:
	@echo "\nSetting up...\n"

	@echo "Installing Homebrew..."
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	@echo "Installing apps from Brewfile..."
	brew bundle

	@echo "Installing Oh My Zsh..."
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	@echo "Installed Oh My Zsh. $$SHELL"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k || true
	echo 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

	@echo "Installing Oh My Zsh plugins..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
	git clone https://github.com/zsh-users/zsh-completions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions || true

	@echo "Updating .zshrc with new plugins..."
	for plugin in $(PLUGINS); do \
		if ! grep -q "$$plugin" ~/.zshrc; then \
			sed -i '' "/^plugins=/ s/)/ $$plugin)/" ~/.zshrc; \
		fi; \
	done
	@echo ".zshrc updated."

	# Vim setup
	echo 'syntax on' >> ~/.vimrc
	echo 'set t_Co=256' >> ~/.vimrc
	echo 'set fileencodings=utf-8' >> ~/.vimrc

	# Aliases
	echo 'alias vsc="code"' >> ~/.zshrc
	echo 'alias xcode="open -a Xcode"' >> ~/.zshrc
	echo 'alias simulator="open -a Simulator"' >> ~/.zshrc
	@echo "\nSetup complete. Run 'source ~/.zshrc' to reload your shell."
.PHONY: setup

configure:
	@echo "\nConfiguring git...\n"

	git config --global user.name $(NAME)  # Set global Git username
	git config --global user.email $(EMAIL)  # Set global Git email
	curl -sL https://www.toptal.com/developers/gitignore/api/$(GITIGNORE) -o ~/.gitignore_global  # Download .gitignore template
	git config --global core.excludesfile ~/.gitignore_global  # Set global .gitignore file
.PHONY: configure

install-dev:
	@echo "\nInstalling development tools...\n"

	python -m pip install --user virtualenv  # Virtual environments for Python
.PHONY: install-dev

install-dev-bed:
	@echo "\nInstalling backend tools...\n"
	@echo "Backend apps installed via Brewfile."
.PHONY: install-dev-bed

install-dev-ios:
	@echo "\nInstalling iOS development tools...\n"

	pod setup  # Set up CocoaPods master repo
.PHONY: install-dev-ios

install-design:
	@echo "\nInstalling design tools...\n"
	@echo "Design apps installed via Brewfile."
.PHONY: install-design

install-productivity:
	@echo "\nInstalling productivity tools...\n"
	@echo "Productivity apps installed via Brewfile."
.PHONY: install-productivity

install-teamwork:
	@echo "\nInstalling teamwork tools...\n"
	@echo "Teamwork apps installed via Brewfile."
.PHONY: install-teamwork

install-fun:
	@echo "\nInstalling fun tools...\n"
	@echo "Fun apps installed via Brewfile."
.PHONY: install-fun

preferences:
	@echo "\nApplying macOS preferences...\n"

	defaults import com.apple.dock mac_preferences/com.apple.dock
	defaults import com.apple.finder mac_preferences/com.apple.finder
	defaults import com.apple.driver.AppleBluetoothMultitouch.trackpad mac_preferences/com.apple.driver.AppleBluetoothMultitouch.trackpad
	defaults import com.apple.Terminal mac_preferences/com.apple.Terminal
	killall Dock Finder
	@echo "macOS preferences applied."
.PHONY: preferences
