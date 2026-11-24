{ pkgs, ... }:
{
	programs.alacritty = {
		enable = true;
		settings = {
			general = {
				import = ["~/.config/alacritty/themes/noctalia.toml"];
			};
			window = {
				# opacity = 0.8;
				# blur = true;
				decorations = "none";
				padding = {
					x = 6;
					y = 6;
				};
			};
		};
	};
}
