{
	imports = [
		./hardware-configuration.nix
			./other.nix
			./packages.nix
			./programs.nix
			./services.nix
# ../../commons/src/default.nix
# ../../commons/src/prepkgs.nix
	];

	system.stateVersion = "26.05";
}
