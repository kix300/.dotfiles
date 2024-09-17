{pkgs, ...}:
{
	stylix = {
		enable = true;
		image = ./srcs/wallpaper.png;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};
	};

	gtk = {
		enable = true;
		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};	
	};
}
