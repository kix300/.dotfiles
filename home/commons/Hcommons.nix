{ pkgs, ... }:
{
	imports = [
		# ./../../commons/stylix.nix
		./../../commons/nixvim/nixvim.nix
		./programs
	];

	home = {
		pointerCursor = {
			enable = true;
			gtk.enable = true;
			x11.enable = true;
			name = "Bibata-Modern-Ice";
			package = pkgs.bibata-cursors;
			size = 24;
		};
	};

	home.stateVersion = "23.11";
}
