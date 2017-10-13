#!/usr/bin/env bash

set -e
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
bld=`tput bold`
fmt="%-10s%-10s\n"

function program_is_installed()
{
    local count=0
    echo ""
    for i in "$@"
    do
        type $i >/dev/null 2>&1 && printf " $fmt" "$i" "${bld}${green}+${reset}"\
        || { printf " $fmt" "$i" "${bld}${red}-${reset}"; count=$((count+1)); }
    done
    if [ ! $count == 0 ]
    then
        echo -e "\nInstall needed tools first!!!\n"
        exit 1
    fi
    echo ""
}

function show_usage()
{
    echo -e "\nUsage: install.sh [PARAMETER]...\nScript for installing my default dotfiles\nAnd Powerline fonts\n"
    echo -e "check\t--Check if needed tools are installed"
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

program_is_installed rsync fc-cache vim screen

trap 'echo ""; echo "Exiting script..."; exit 1;' SIGINT SIGQUIT SIGTSTP
while [ -n "$1" ]
do
case $1 in
"check" )
    echo -e "Just checking"
    ;;
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
