{ config, pkgs, ... }:

{
	imports =
		[
		./hardware-configuration.nix
		./other.nix
		./packages.nix
		];

	system.stateVersion = "25.11";

}
