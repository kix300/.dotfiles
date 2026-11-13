{ pkgs, ... }:
{
	programs.alacritty = {
		enable = true;
		settings = {
			general = {
				import = ["~/.config/alacritty/themes/noctalia.toml"];
			};
			window = {
				decoration = "none";
				padding = {
					x = 6;
					y = 6;
				};
			};
		};
	};
}
