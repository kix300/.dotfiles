{
	description = "A simple NixOS flake";

	inputs = {
# NixOS official package source, using the nixos-23.11 branch here
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		stylix.url = "github:danth/stylix";
		nixvim-flake.url = "github:kix300/nixvim-flake";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-index-database.url = "github:nix-community/nix-index-database";
		nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
		ags.url = "github:Aylur/ags";
		ags.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, nixos-hardware, home-manager, ags, nix-index-database, stylix, ... }@inputs: let
		inherit (self) outputs;
	in {
		nixosConfigurations.OzenOs = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs outputs; };
			modules = [
				./configuration.nix
				nixos-hardware.nixosModules.asus-zephyrus-ga401
				nixos-hardware.nixosModules.asus-battery
				nix-index-database.nixosModules.nix-index
				{
					hardware.asus.battery.chargeUpto = 85;
				}
				home-manager.nixosModules.home-manager
				{
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.extraSpecialArgs = { inherit inputs;};
				home-manager.sharedModules = [
				stylix.homeManagerModules.stylix
				ags.homeManagerModules.default
				];
				home-manager.users.ozen = import ./home.nix;
				}
			];
		};
	};
}
