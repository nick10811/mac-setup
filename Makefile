NAME = "Your Name"
EMAIL = "your@email.com"
GITIGNORE = "linux,swift,xcode,macos,objective-c,visualstudiocode"

INTEL_FLAGS = ""
ifneq ($(filter arm%,$(shell uname -p)),)
	INTEL_FLAG = "arch -x86_64"
endif

all: setup configure install-dev install-dev-ios install-design install-productivity install-teamwork install-fun
.PHONY: all

setup:
	@echo "Setting up"
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install wget
	brew install nmap
.PHONY: setup

configure:
	@echo "Configuring git..."
	git config --global user.name $(NAME)
	git config --global user.email $(EMAIL)
	curl -sL https://www.gitignore.io/api/$(GITIGNORE) -o ~/.gitignore_global
	git config --global core.excludesfile ~/.gitignore
.PHONY: configure

install-dev:
	@echo "Installing development tools..."
	brew install git
	brew install gitmoji # integrate emoji into git commit
	brew install --cask fork # GUI for git
	brew install --cask iterm2 # terminal
	brew install --cask visual-studio-code # Code editor

	brew install --cask docker # Container
	# brew install nvm # node version manager
	# brew install nodejs

	brew install --cask postman # API tool
	# brew install --cask proxyman # Inspect HTTP(s) requests/responses
.PHONY: install-dev

install-dev-ios:
	@echo "Installing iOS development tools..."
	brew install cocoapods
	# sudo gem install cocoapods -v 1.7.1
	pod setup
	brew install carthage
	# brew install fastlane # automate tool

	# brew install --cask dash # Offline API document
	# brew install --cask android-studio # Android development GUI
.PHONY: install-dev-ios

install-design:
	@echo "Installing design tools..."
	brew install --cask figma # Design tool
	brew install --cask zeplin # Design tool
.PHONY: install-design

install-productivity:
	@echo "Installing productivity tools..."
	brew install bat # customized of 'cat'
	brew install --cask appcleaner
	brew install --cask the-unarchiver
	brew install --cask coconutbattery

	brew install --cask google-chrome
	# brew install --cask brave-browser

	brew install --cask notion
	# brew install --cask teamviewer # remote tool
	# brew install --cask anydesk # remote tool

	# brew install --cask time-out # remind you to break

	# brew install --cask typora # MARKDOWN editor
	# brew install --cask macdown # MARKDOWN editor
.PHONY: install-productivity

install-teamwork:
	@echo "Installing teamwork tools..."
	brew install --cask hamsket-nightly # all-in-one messaging station
	# brew install --cask slack
	# brew install --cask discord
	# brew install --cask telegram
	# brew install --cask zoomus
	# brew install --cask skype
	# brew install --cask microsoft-teams
.PHONY: install-teamwork

install-fun:
	@echo "Installing fun tools..."
	brew install --cask spotify
	# brew install --cask vlc
.PHONY: install-fun