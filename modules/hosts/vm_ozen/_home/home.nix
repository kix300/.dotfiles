{ pkgs, ... }:
{
	home = {
		username = "kiki";
		homeDirectory = "/home/kiki";
	};
	programs = {
		home-manager.enable = true;
	};
}
