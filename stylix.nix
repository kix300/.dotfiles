{pkgs, ...}:
{
	stylix = {
		enable = true;
		image = ./srcs/seoulstreet.jpg;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		#base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
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
		enable = true;
		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};
	};
}
