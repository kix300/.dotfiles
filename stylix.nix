{pkgs, ...}:
{
	stylix = {
		enable = true;
		image = ./srcs/tokyonight.jpg;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};
		targets = {
				gtk.enable = true;
				xfce.enable = true;
				wofi.enable = true;
		};
		opacity.terminal = 1.0;
	};

	gtk = {
		enable = true;
		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};	
	};
}
