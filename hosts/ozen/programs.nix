{
	pkgs,
	...
}:
{
	programs = {
		hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
		hyprland = {
			enable = true;
			withUWSM = true;
			xwayland.enable = true;
		};
		steam = {
			enable = true;
			gamescopeSession.enable = true;
		};
		gamescope = {
			enable = true;
			capSysNice = true;
		};
	};
}
