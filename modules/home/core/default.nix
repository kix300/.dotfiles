{ config, ... }:
{
	flake.modules.homeManager.core = {
		imports = with config.flake.modules.homeManager; [
			theme
			programs
		];

		home.stateVersion = "23.11";
	};
}
