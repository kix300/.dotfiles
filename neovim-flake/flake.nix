{
	description = "A nixvim configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixvim.url = "github:nix-community/nixvim";
		flake-parts.url = "github:hercules-ci/flake-parts";
	
		#vim plugin
		plugin_conform-nvim = {
			url = "github:stevearc/conform.nvim";
			#flake = false;
		};
		plugin_lazyvim-nvim = {
			url = "github:folke/lazy.nvim";
			#flake = false;
		};
		plugin_gruvbox-nvim = {
			url = "github:ellisonleao/gruvbox.nvim";
			#flake = false;
		};

	};

}
