{
	lib,
	pkgs,
	...
}:
{

	services = {
		thermald.enable = true;
		xserver = {
			enable = lib.mkForce false;
		};
		desktopManager.plasma6.enable = lib.mkForce false;
		displayManager.sddm.enable = lib.mkForce false;
		displayManager.gdm.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};

}
