{pkgs, ...}:
{
	stylix = {
		enable = true;
		image = ./srcs/night.webp;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-terminal-dark.yaml";
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
		opacity.terminal = 0.8;
	};

	gtk = {
		enable = true;
		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};	
	};
}
