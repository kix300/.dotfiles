{
	description = "Kix's Flake";

	inputs = {
		nixvim.url = "github:nix-community/nixvim";
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		stylix.url = "github:danth/stylix";
		noctalia = {
			url = "github:noctalia-dev/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-index-database.url = "github:nix-community/nix-index-database";
		nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
		zen-browser.url = "github:0xc000022070/zen-browser-flake";
	};

	outputs =
		{
		self,
		nixpkgs,
		nixos-hardware,
		home-manager,
		nix-index-database,
		stylix,
		nixvim,
		noctalia,
		...
		}@inputs:
		let
			inherit (self) outputs;
			forAllSystems = nixpkgs.lib.genAttrs [
				"aarch64-linux"
				"i686-linux"
				"x86_64-linux"
				"aarch64-darwin"
				"x86_64-darwin"
			];
		in rec
			{
			devShells = forAllSystems (
				system:
				let
					pkgs = nixpkgs.legacyPackages.${system};
				in
					pkgs.mkShell {
						nativeBuildInputs = with pkgs; [
							readline
						];
						shellHook = ''fish'';
					}
			);

			nixosConfigurations = {
				laptop = nixpkgs.lib.nixosSystem rec {
					system = "x86_64-linux";
					specialArgs = { inherit inputs outputs system; };
					modules = [
						./hosts/ozen
						nixos-hardware.nixosModules.asus-zephyrus-ga401
						nixos-hardware.nixosModules.asus-battery
						nix-index-database.nixosModules.nix-index
						# {
						#   hardware.asus.battery.chargeUpto = 85;
						# }
						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								backupFileExtension = ".bak";
								extraSpecialArgs = { inherit inputs; };
								sharedModules = [
									stylix.homeModules.stylix
									nixvim.homeModules.nixvim
									noctalia.homeModules.default
								];
								users.ozen = import ./home/ozen/home.nix;

							};
						}
					];
				};
				home = nixpkgs.lib.nixosSystem rec {
					system = "x86_64-linux";
					specialArgs = { inherit inputs outputs system; };
					modules = [
						./hosts/ozen_home
						nix-index-database.nixosModules.nix-index
						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								backupFileExtension = ".bak";
								extraSpecialArgs = { inherit inputs; };
								sharedModules = [
									stylix.homeModules.stylix
									nixvim.homeModules.nixvim
									noctalia.homeModules.default
								];
								users.ozen = import ./home/ozen/home.nix;

							};
						}
					];
				};
				ozen_work = nixpkgs.lib.nixosSystem rec {
					system = "x86_64-linux";
					specialArgs = { inherit inputs outputs system; };
					modules = [
						./hosts/ozen_work
						nix-index-database.nixosModules.nix-index
						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								backupFileExtension = ".bak";
								extraSpecialArgs = { inherit inputs; };
								sharedModules = [
									stylix.homeModules.stylix
									nixvim.homeModules.nixvim
									noctalia.homeModules.default
								];
								users.ozen_work = import ./home/ozen_work/home.nix;
							};
						}
					];
				};
				meptik = nixpkgs.lib.nixosSystem rec {
					system = "x86_64-linux";
					specialArgs = { inherit inputs outputs system; };
					modules = [
						./hosts/meptik
						# ASUS TUF fx506hm
						nixos-hardware.nixosModules.asus-fx506hm
						nix-index-database.nixosModules.nix-index
						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								backupFileExtension = ".bak";
								extraSpecialArgs = { inherit inputs; };
								sharedModules = [
									stylix.homeModules.stylix
									nixvim.homeModules.nixvim
									noctalia.homeModules.default
								];
								users.meptik = import ./home/meptik/home.nix;
							};
						}
					];
				};
			};

			homeConfigurations = {
				ozen = nixosConfigurations.home.config.home-manager.users."ozen".home;
			};
		};
}
