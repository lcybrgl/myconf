#!/usr/bin/env bash

set -e
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
bld=`tput bold`
fmt="%-12s%-12s\n"
backdir=~/dotfiles-`date +%Y%m%d`

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
    echo -e "console\t--Install vim-plugins, dotfiles and fonts"
    echo ""
    exit 1
}

function syncf()
{
    for i in "$@"
    do
        if [ -f ~/.$i ]
        then
            cp -a ~/.$i $backdir/.$i.bak
            rsync dotfiles/$i ~/.$i 1>/dev/null
        else
            rsync dotfiles/$i ~/.$i 1>/dev/null
        fi
    done
}

[ $USER == "root" ] && { echo "Do NOT run as root!!!"; exit 1; }
[ ! -n "$1" ] && show_usage

trap 'echo ""; echo "Exiting script..."; exit 1;' SIGINT SIGQUIT SIGTSTP
while [ -n "$1" ]
do
case $1 in
"check" )
    echo -e "Just checking"
    program_is_installed rsync fc-cache vim screen
    ;;
"console" )
    program_is_installed rsync fc-cache vim screen
    echo "Installing fonts..."
    sudo rsync -arv fonts/* /usr/share/fonts/ 1>/dev/null
    sudo fc-cache -f 1>/dev/null
    echo "Installing vim-plugins..."
    rsync -arv vim-plugins/bundle ~/.vim/ --delete 1>/dev/null
    echo "Installing dotfiles..."
    if [ ! -d "$backdir" ]
    then
        mkdir $backdir
    fi
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
