{ pkgs, ... }:
{
	imports = [
		./../commons/Hcommons.nix
	];
	home = {
		username = "kiki";
		homeDirectory = "/home/kiki";
	};
	programs = {
		home-manager.enable = true;
		git = {
			signing.format = "openpgp";
			settings.user.name = "kix300";
			settings.user.email = "kixwalkiki@gmail.com";
		};
	};


	xdg.configFile."niri/config.kdl".source = niri/config.kdl;
	home.stateVersion = "23.11";
}
