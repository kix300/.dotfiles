{pkgs, ...}:
{
	stylix = {
		enable = true;
		# image = ./srcs/forest.jpg;
		# polarity = "dark";
		# base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
		# #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};
		# opacity.terminal = 0.5;
		# targets = {
		# 	gtk.enable = true;
		# 	xfce.enable = true;
		# 	wofi.enable = true;
		# 	firefox.profileNames = [ "default" ];
		# 	zed.enable = false;
		# 	nixvim = {
		# 		enable = true;
		# 		plugin = "base16-nvim";
		# 		transparentBackground = {
		# 			signColumn = true;
		# 			numberLine = true;
		# 			main = true;
		# 		};
		# 	};
		# };
		#
	};

	gtk = {
		enable = true;
		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};
	};
}
