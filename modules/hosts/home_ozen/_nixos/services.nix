{
lib,
pkgs,
...
}:
{
	services = {
		displayManager = {
			noctalia-greeter = {
				enable = true;
				settings = {
					cursor.size = 24;
					keyboard.layout = "us";
				};
				cursorTheme = {
					package = pkgs.bibata-cursors;
					name = "Bibata-Modern-Ice";
				};
				settings = {
					appearance = {
						scheme = "Synced";
						theme_mode = "light";
					};
				};
			};
			sddm.enable = lib.mkForce false;
			gdm.enable = lib.mkForce false;
		};
		thermald.enable = lib.mkForce false;
		xserver = {
			enable = lib.mkForce false;
		};
		desktopManager.plasma6.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};

}
