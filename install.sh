# !/bin/bash
#  Program:
#        This program installs all necessary packages by Nick.
#
# Created by Nick Yang on 2022/3/5.
# Copyright © 2022 Nick Yang All rights reserved.

function installBasic() {
    echo
    echo "+------------------------+"
    echo "| Installing Basic Tools |"
    echo "+------------------------+"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install wget
    brew install nmap
    echo
    echo
}

function installDevelopment() {
    echo
    echo "+------------------------------+"
    echo "| Installing Development Tools |"
    echo "+------------------------------+"
    brew install git
    brew install gitmoji # integrate emoji into git commit
    brew install cocoapods
    # sudo gem install cocoapods -v 1.7.1
    pod setup
    brew install carthage
    # brew install fastlane # automate tool
    brew install --cask visual-studio-code # Code editor
    brew install --cask fork # GUI for git
    brew install --cask postman # API tool
    # brew install --cask typora # MARKDOWN editor
    # brew install --cask macdown #MARKDOWN editor
    brew install --cask iterm2 # terminal
    # brew install --cask zeplin # Design tool
    # brew install --cask figma # Design tool
    # brew install --cask dash # Offline API document
    # brew install --cask proxyman # Inspect HTTP(s) requests/responses
    # brew install --cask android-studio # Android development GUI
    echo
    echo
}

function installProductivity() {
    echo
    echo "+-------------------------------+"
    echo "| Installing Productivity Tools |"
    echo "+-------------------------------+"
    brew install bat # customized of 'cat'
    brew install --cask appcleaner
    brew install --cask the-unarchiver
    brew install --cask google-chrome
    # brew install --cask brave-browser
    brew install --cask coconutbattery
    brew install --cask notion
    # brew install --cask teamviewer # remote tool
    # brew install --cask anydesk # remote tool
    echo
    echo
}

function installTeamwork() {
    echo
    echo "+---------------------------+"
    echo "| Installing Teamwork Tools |"
    echo "+---------------------------+"
    # brew install --cask rambox # all-in-one messaging station
    # brew install --cask slack
    # brew install --cask discord
    # brew install --cask telegram
    # brew install --cask skype
    # brew install --cask zoomus
    echo
    echo
}

function installOthers() {
    echo
    echo "+------------------------+"
    echo "| Installing Other Tools |"
    echo "+------------------------+"
    brew install --cask spotify
    # brew install --cask time-out # remind you to break
    # brew install --cask docker
    # brew install nvm # node version manager
    # brew install nodejs
    echo
    echo
}

function setupGit() {
    while getopts u:e: option 
    do
        case $option in
            u) USERNAME=${OPTARG};;
            e) EMAIL=${OPTARG};;
        esac
    done

    if [ ! -z "${USERNAME}" ]; then
	    git config --global user.name "${USERNAME}"
    fi
    if [ ! -z "${EMAIL}" ]; then
        git config --global user.email "${EMAIL}"
    fi

    QUERY="linux,swift,xcode,macos,objective-c,visualstudiocode"
    curl -sL https://www.gitignore.io/api/${QUERY} -o ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
    
    echo
    echo "+-------------------+"
    echo "| Git Configuration |"
    echo "+-------------------+"
    cat ~/.gitconfig
    echo
    echo
}

function printDone() {
    echo
    echo "+----------------------------------------------+"
    echo "| Successfully install all necessary software. |" 
    echo "| Have fun on your Mac.                        |"
    echo "+----------------------------------------------+"
    echo
    echo "                                 .''."
    echo "       .''.             *''*    :_\/_:     . "
    echo "      :_\/_:   .    .:.*_\/_*   : /\ :  .'.:.'."
    echo "  .''.: /\ : _\(/_  ':'* /\ *  : '..'.  -=:o:=-"
    echo " :_\/_:'.:::. /)\*''*  .|.* '.\'/.'_\(/_'.':'.'"
    echo " : /\ : :::::  '*_\/_* | |  -= o =- /)\    '  *"
    echo "  '..'  ':::'   * /\ * |'|  .'/.\'.  '._____"
    echo "      *        __*..* |  |     :      |.   |' .---\"|"
    echo "       _*   .-'   '-. |  |     .--'|  ||   | _|    |"
    echo "    .-'|  _.|  |    ||   '-__  |   |  |    ||      |"
    echo "    |' | |.    |    ||       | |   |  |    ||      |"
    echo " ___|  '-'     '    \"\"       '-'   '-.'    '\`      |____"
    echo "jgs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

# main
installBasic
installDevelopment
setupGit "$@"
installProductivity
installTeamwork
installOthers

printDone
exit 0
