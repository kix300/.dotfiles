{ config, pkgs, ... }:

{
	imports =
		[
		./hardware-configuration.nix
		./other.nix
		];

	system.stateVersion = "25.11";

}
