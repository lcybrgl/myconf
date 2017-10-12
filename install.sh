#!/usr/bin/env bash

set -e
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# echo "node: $(program_is_installed node)"
function program_is_installed {
    type $1 >/dev/null 2>&1 || { echo -e "\"${1}\" is installed:    ${red} \u2718 ${reset}"; exit 1; }
}

function show_usage()
{
    echo -e "\nUsage: install.sh [PARAMETER]...\nScript for installing my default dotfiles\nAnd Powerline fonts\n"
    echo -e "vim\t--Install vim-plugins"
    echo -e "dfiles\t--Install config files"
    echo -e "fonts\t--Install fonts"
    echo -e "all\t--Install vim-plugins, dotfiles and fonts"
    echo ""
    exit 1
}

function syncf()
{
    for i in "$@"
    do
        if [ -f ~/.$i ]
        then
            cp -a ~/.$i ~/.$i.bak
            rsync dotfiles/$i ~/.$i 1>/dev/null
        else
            rsync dotfiles/$i ~/.$i 1>/dev/null
        fi
    done
}

program_is_installed rsync
program_is_installed fc-cache
program_is_installed vim
program_is_installed screen

[ $USER == "root" ] && { echo "Do NOT run as root!!!"; exit 1; }
[ ! -n "$1" ] && show_usage

trap 'echo ""; echo "Exiting script..."; exit 1;' SIGINT SIGQUIT SIGTSTP
while [ -n "$1" ]
do
case $1 in
"fonts" )
    echo "Installing fonts..."
    sudo rsync -arv fonts/* /usr/share/fonts/ 1>/dev/null
    sudo fc-cache -f
    echo -e "Installed Powerline fonts:         ${green}\xE2\x9C\x94${reset}"
    ;;
"vim" )
    echo "Installing vim-plugins..."
    rsync -ar vim/bundle ~/.vim/ 1>/dev/null
    echo -e "Installed vim-plugins:             ${green}\xE2\x9C\x94${reset}"
    ;;
"dfiles" )
    echo "Installing dotfiles..."
    syncf bashrc vimrc screenrc Xresources
    echo -e "Installed dotfiles:                ${green}\xE2\x9C\x94${reset}"
    ;;
"all" )
    echo "Installing fonts..."
    sudo rsync -arv fonts/* /usr/share/fonts/ 1>/dev/null
    sudo fc-cache -f 1>/dev/null
    echo -e "Installed Powerline fonts:         ${green}\xE2\x9C\x94${reset}"
    echo "Installing vim-plugins..."
    rsync -arv vim/bundle ~/.vim/ --delete 1>/dev/null
    echo -e "Installed vim-plugins:             ${green}\xE2\x9C\x94${reset}"
    echo "Installing dotfiles..."
    syncf bashrc vimrc screenrc Xresources
    echo -e "Installed dotfiles:                ${green}\xE2\x9C\x94${reset}"
    ;;
* )
    show_usage
    ;;
esac
shift
done

trap - SIGINT SIGQUIT SIGTSTP
exit 0
