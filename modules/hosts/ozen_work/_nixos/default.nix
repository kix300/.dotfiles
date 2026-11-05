{ pkgs, lib, ... }:

{
	imports = [
		./hardware-configuration.nix
		./other.nix
	];

	system.stateVersion = "26.05";
}
