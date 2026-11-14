{ config, ... }:
{
	flake.modules.homeManager.programs.imports =
		with config.flake.modules.homeManager; [
			alacritty
			fish
			git
			starship
			zed-editor
			zellij
			zoxide
		];
}
