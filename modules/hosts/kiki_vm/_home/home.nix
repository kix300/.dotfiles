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
	};
	home.stateVersion = "23.11";
}
