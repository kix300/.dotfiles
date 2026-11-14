{lib, ...}:
{
	programs = {
		hyprland = {
			enable = lib.mkForce false;
			withUWSM = lib.mkForce true;
			xwayland.enable = lib.mkForce false;
		};
		kdeconnect.enable = true;

		niri = {
			enable = true;
			useNautilus = true;
		};
	};
}
