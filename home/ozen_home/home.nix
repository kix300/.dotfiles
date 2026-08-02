{ pkgs, ... }:
{
	imports = [
		./../commons/Hcommons.nix
	];
	home = {
		username = "ozen";
		homeDirectory = "/home/ozen";
	};
	programs = {
		home-manager.enable = true;
		git = {
			signing.format = "openpgp";
			settings.user.name = "kix300";
			settings.user.email = "kixwalkiki@gmail.com";
		};
	};
	# pour creer un fichier xdg desktop portal hyprland et donc screensharing
	# util ? je sais plus on va keep
	systemd.user.services.xdg-desktop-portal-hyprland = {
		Unit = {
			Description = "XDG Desktop Portal Hyprland";
			PartOf = [ "graphical-session.target" ];
			After = [ "graphical-session.target" ];
		};
		Service = {
			Type = "dbus";
			BusName = "org.freedesktop.impl.portal.desktop.hyprland";
			ExecStart = "${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland";
			Restart = "on-failure";
			RestartSec = 5;
		};
		Install = {
			WantedBy = [ "graphical-session.target" ];
		};
	};
	wayland.windowManager.hyprland = {
		enable = true;
		wayland.windowManager.hyprland.configType = "lua";
		extraConfig = "
			${builtins.readFile ./hypr/hyprland/hyprland.lua}
			";
	};

	home.stateVersion = "23.11";
}
