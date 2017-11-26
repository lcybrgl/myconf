#!/usr/bin/env bash

set -e
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
bld=`tput bold`
fmt="%-12s%-12s\n"
backdir=~/dotfiles-bak

function show_usage()
{
    echo -e "\nUsage: install.sh [PARAMETER]...\nScript for installing my default dotfiles\nAnd Powerline fonts\n"
    echo -e "all\t--Install fonts, dotfiles, vim plugins"
    echo -e "dfiles\t--Install only dotfiles"
    echo -e "vim\t--Install only vim plugins"
    echo -e "fonts\t--Install fonts to local user dir"
    echo ""
    exit 1
}

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

function syncf()
{
    if [ ! -d "$backdir" ]
    then
        mkdir $backdir
    fi

    for i in "$@"
    do
        if [ -f ~/.$i ]
        then
            local count=`ls -l $backdir| grep $i | wc -l`
            if [ "$count" == 0 ]
            then
                cp -a ~/.$i $backdir/$i-`date +%Y%m%d`
            else
                cp -a ~/.$i $backdir/$i-`date +%Y%m%d`-${count}
            fi
            rsync dotfiles/$i ~/.$i 1>/dev/null
        else
            rsync dotfiles/$i ~/.$i 1>/dev/null
        fi
    done
}

[ $USER == "root" ] && { echo "Do NOT run as root!!!"; exit 1; }
[ ! -n "$1" ] && show_usage

trap 'echo ""; echo "Exiting script..."; exit 1;' SIGINT SIGQUIT SIGTSTP
program_is_installed rsync fc-cache vim screen

while [ -n "$1" ]
do
case $1 in
"all" )
    echo -n "Installing fonts..."
    rsync -arv fonts/* ~/.fonts/ 1>/dev/null
    fc-cache -f ~/.fonts 1>/dev/null
    echo " ${bld}${green}+${reset}"
    echo -n "Installing vim-plugins..."
    rsync -arv vim-plugins/bundle ~/.vim/ --delete 1>/dev/null
    echo " ${bld}${green}+${reset}"
    echo -n "Installing dotfiles..."
    syncf bashrc vimrc screenrc Xresources
    xrdb -merge ~/.Xresources
    echo " ${bld}${green}+${reset}"
    ;;
"dfiles" )
    echo -n "Installing dotfiles..."
    syncf bashrc vimrc screenrc Xresources
    xrdb -merge ~/.Xresources
    echo " ${bld}${green}+${reset}"
    ;;
"fonts" )
    echo -n "Installing fonts..."
    rsync -arv fonts/* ~/.fonts/ 1>/dev/null
    fc-cache -f ~/.fonts 1>/dev/null
    echo " ${bld}${green}+${reset}"
    ;;
"vim" )
    echo -n "Installing vim-plugins..."
    rsync -arv vim-plugins/bundle ~/.vim/ --delete 1>/dev/null
    echo " ${bld}${green}+${reset}"
    ;;
* )
    show_usage
    ;;
esac
shift
done

trap - SIGINT SIGQUIT SIGTSTP
exit 0
