{
	flake.modules.homeManager.hyprland =
		{ pkgs, ... }:
		{
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
				Install.WantedBy = [ "graphical-session.target" ];
			};

			wayland.windowManager.hyprland = {
				enable = true;
				configType = "lua";
				extraConfig = builtins.readFile ./hyprland.lua;
			};
		};
}
