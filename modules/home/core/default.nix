{ pkgs, ... }:
{
	flake.modules.homeManager.core = {
		imports = [
			./theme.nix
			./programs
		];

		home.stateVersion = "23.11";
	};
}
