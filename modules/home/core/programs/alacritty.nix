{
	flake.modules.homeManager.alacritty =
		{ pkgs, ... }:
		{
	programs.alacritty = {
		enable = true;
		settings = {
			window = {
				decorations = "none";
				padding = {
					x = 6;
					y = 6;
				};
			};
		};
	};
		};
}
