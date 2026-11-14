{ pkgs, lib, ... }:

{
	imports = [
		./hardware-configuration.nix
		./packages.nix
		./other.nix
	];

	system.stateVersion = "26.05";
}
