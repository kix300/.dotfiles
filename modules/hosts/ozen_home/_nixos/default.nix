{
	imports = [
		./hardware-configuration.nix
			./packages.nix
			./services.nix
			./programs.nix
			./other.nix
			./msi.nix
	];

	system.stateVersion = "26.05";
}
