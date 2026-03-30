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
		nix-ld.enable = true;
		direnv = {
			package = pkgs.direnv;
			silent = false;
			loadInNixShell = true;
			direnvrcExtra = "";
			nix-direnv = {
				enable = true;
				package = pkgs.nix-direnv;
			};
		};
		gamescope = {
			enable = true;
			capSysNice = true;
		};
	};
}
