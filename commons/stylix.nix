{pkgs, ...}:
{
	stylix = {
		enable = true;
		image = ./srcs/forest.jpg;
		polarity = "dark";
		base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
		#base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};
		# opacity.terminal = 1;
		targets = {
			gtk.enable = true;
			xfce.enable = true;
			wofi.enable = true;
			nixvim.enable = true;
			nixvim.plugin = "base16-nvim";
			firefox.profileNames = [ "default" ];
			zed.enable = false;
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
