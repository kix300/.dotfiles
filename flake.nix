{
  #ttttt
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nix-index-database, ... }@inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations.OzenOs = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs; };
      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.asus-zephyrus-ga401
	nixos-hardware.nixosModules.asus-battery
        {
          hardware.asus.battery.chargeUpto = 85;
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
          nix-index-database.hmModules.nix-index
          ];

          home-manager.users.ozen = import ./home.nix;
        }
      ];
    };
  };
}
