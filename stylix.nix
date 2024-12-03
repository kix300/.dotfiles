{pkgs, ...}:
{
	stylix = {
		enable = true;
		image = ./srcs/landscape.jpg;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};
		opacity.terminal = 0.8;
		targets = {
				gtk.enable = true;
				xfce.enable = true;
				wofi.enable = true;
		};
	};

	gtk = {
		enable = false;
		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};	
	};
}
