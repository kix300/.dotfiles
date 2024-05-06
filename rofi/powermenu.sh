#!/bin/bash

lock=" "
logout=" "
sleep=" "
reboot="󰦛 "
shutdown=" "

selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu -i -p "Powermenu" \
	-theme "~/.dotfiles/rofi/style-4.rasi")

if [ "$selected_option" == "$lock" ]; then
	swaylock-fancy
elif [ "$selected_option" == "$logout" ]; then
	loginctl terminate-user $(whoami)
elif [ "$selected_option" == "$shutdown" ]; then
	poweroff
elif [ "$selected_option" == "$reboot" ]; then
	loginctl reboot
elif [ "$selected_option" == "$sleep" ]; then
	loginctl suspend
else
	echo "No match"
fi
