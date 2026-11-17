{
	description = "Kix's Flake";

	inputs = {
		flake-parts = {
			url = "github:hercules-ci/flake-parts";
			inputs.nixpkgs-lib.follows = "nixpkgs";
		};
	    import-tree.url = "github:vic/import-tree";

		nixvim = {
			url = "github:nix-community/nixvim";
		};

		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		stylix = {
			url = "github:danth/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		noctalia = {
			url = "github:noctalia-dev/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-index-database = {
			url = "github:nix-community/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser =  {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs =
		{ flake-parts, ... }@inputs:
		flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
