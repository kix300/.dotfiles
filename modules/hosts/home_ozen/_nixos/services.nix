{
lib,
pkgs,
...
}:
{
	services = {
		thermald.enable = lib.mkForce false;
		xserver = {
			enable = lib.mkForce false;
		};
		desktopManager.plasma6.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};

}
