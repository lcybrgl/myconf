#!/bin/bash
set -e

# installing refector to test wich servers are fastest
sudo pacman -S --noconfirm --needed reflector

# finding the fastest archlinux servers
sudo reflector -l 100 --score 30 --sort rate --threads 20 --verbose -x osbeck -x tomforb --save /tmp/mirrorlist && rankmirrors -n -v /tmp/mirrorlist && sudo cp /tmp/mirrorlist /etc/pacman.d/mirrorlist

