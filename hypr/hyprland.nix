
{ config, pkgs, ... }:

{
	home-manager.users.Ozen.wayland.configFile = {
		"hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
	};
	wayland.windowManager.hyprland = {
		enable = true;
	};
}

