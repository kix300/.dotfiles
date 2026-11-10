{ config, pkgs, ... }:

{
	imports =
		[
		./hardware-configuration.nix
		./other.nix
		# ../../commons/src/programs.nix
		# ../../commons/src/packages.nix
		];

	system.stateVersion = "25.11";

}
