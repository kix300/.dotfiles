{lib, ...}:
{
	programs = {
		hyprland = {
			enable = lib.mkForce false;
			withUWSM = lib.mkForce true;
			xwayland.enable = lib.mkForce false;
		};
		niri = {
			enable = true;
			useNautilus = true;
		};
	};
	xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
		config = {
			common = {
				default = [ "gtk" ];
			};
			niri = lib.mkForce {
				default = [ "gtk" ];
				"org.freedesktop.impl.portal.Settings" = "gtk";
				"org.freedesktop.impl.portal.FileChooser" = "gtk";
				"org.freedesktop.impl.portal.ScreenCast" = "gnome";
				"org.freedesktop.impl.portal.Screenshot" = "gnome";
			};
		};
	};
}
