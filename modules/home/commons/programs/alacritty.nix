{ pkgs, ... }:
{
	programs.alacritty = {
		enable = true;
		settings = {
			general = {
				import = ["~/.config/alacritty/themes/noctalia.toml"];
			};
			window = {
				decorations = "none";
				padding = {
					x = 6;
					y = 6;
				};
			};
		};
	};
}
