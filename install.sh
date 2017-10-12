#!/usr/bin/env bash

set -e
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# echo "node: $(program_is_installed node)"
function program_is_installed {
    type $1 >/dev/null 2>&1 || { echo "\"${1}\" is installed:    ${red}✘ ${reset}"; exit 1; }
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

[ $USER == "root" ] && { echo "Do NOT run as root!!!"; exit 1; }
[ ! -n "$1" ] && show_usage
program_is_installed rsync
program_is_installed fc-cache
program_is_installed vim
program_is_installed screen

trap 'echo ""; echo "Exiting script..."; exit 1;' SIGINT SIGQUIT SIGTSTP
while [ -n "$1" ]
do
case $1 in
"fonts" )
    echo "Installing fonts..."
    sudo rsync -arv fonts/* /usr/share/fonts/ 1>/dev/null
    sudo fc-cache -f
    ;;
"vim" )
    echo "Installing vim-plugins..."
    rsync -ar vim/bundle ~/.vim/ 1>/dev/null
    ;;
"dfiles" )
    echo "Installing dotfiles..."
    syncf bashrc vimrc screenrc Xresources
    ;;
"all" )
    echo "Installing fonts..."
    sudo rsync -arv fonts/* /usr/share/fonts/ 1>/dev/null
    sudo fc-cache -f 1>/dev/null
    echo "Installing vim-plugins..."
    rsync -arv vim/bundle ~/.vim/ --delete 1>/dev/null
    echo "Installing dotfiles..."
    syncf bashrc vimrc screenrc Xresources
    ;;
* )
    show_usage
    ;;
esac
shift
done

trap - SIGINT SIGQUIT SIGTSTP
exit 0
