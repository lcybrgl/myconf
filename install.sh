#!/usr/bin/env bash

set -e
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


[ $USER == "root" ] && die "Do NOT run as root!!!"
[ ! -n "$1" ] && show_usage

trap 'echo ""; die "Exiting script..."' SIGINT SIGQUIT SIGTSTP

while [ -n "$1" ]
do
case $1 in
"fonts" )
    echo "Installing fonts..."
    sudo rsync -arv fonts/* /usr/share/fonts/
    sudo fc-cache -f
    ;;
"vim" )
    echo "Installing vim-plugins..."
    rsync -ar vim/bundle ~/.vim/
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
