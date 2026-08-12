{
pkgs,
...
}:
{

	xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-hyprland
			pkgs.xdg-desktop-portal-gtk
		];
		configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
		config = {
			common = {
				default = [ "gtk" ];
			};
			hyprland = {
				default = [
					"hyprland"
					"gtk"
				];
				"org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
				"org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
			};
		};
	};
	systemd = {
		sleep.settings.Sleep = {
			AllowSuspend = "no";
			AllowHibernation = "no";
			AllowSuspendThenHibernate = "no";
			AllowHybridSleep  = "no";
		};

		user.services = {
			xdg-desktop-portal-hyprland = {
				enable = true;
				wantedBy = [ "graphical-session.target" ];
				after = [ "graphical-session.target" ];
			};

			xdg-desktop-portal = {
				enable = true;
				wantedBy = [ "graphical-session.target" ];
				after = [ "graphical-session.target" ];
			};
		};
	};
}
