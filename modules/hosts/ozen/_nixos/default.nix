{
...
}:

{
	imports = [
		./hardware-configuration.nix
		./packages.nix
		./services.nix
		./programs.nix
		./other.nix
		# ../../commons/src/default.nix
		# ../../commons/src/nvidia.nix
		# ../../commons/src/prepkgs.nix
	];

	system.stateVersion = "23.05";

}
