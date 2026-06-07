all: _bootstrap _install _configure
.PHONY: all

_bootstrap:
	@echo "\nInstalling Homebrew..."
	@command -v brew > /dev/null || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo "Installing Oh My Zsh..."
	@[ -d "$$HOME/.oh-my-zsh" ] || sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
.PHONY: _bootstrap

_install:
	@echo "\nParsing Setupfile...\n"
	@bash scripts/install.sh Setupfile
.PHONY: _install

_configure:
	@echo "\nApplying shell and editor config...\n"
	@grep -q 'syntax on' "$$HOME/.vimrc" 2>/dev/null || printf 'syntax on\nset t_Co=256\nset fileencodings=utf-8\n' >> "$$HOME/.vimrc"
	@grep -q 'zsh_plugins' "$$HOME/.zshrc" 2>/dev/null || echo 'source ~/.zsh_plugins.zsh' >> "$$HOME/.zshrc"
	@echo "Shell config updated."
.PHONY: _configure
