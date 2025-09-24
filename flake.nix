{
  description = "Kix's Flake";

  inputs = {
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      astal,
      nix-index-database,
      stylix,
      nixvim,
      nix-minecraft,
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
    in
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
            {
              hardware.asus.battery.chargeUpto = 85;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = ".bak";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.sharedModules = [
                stylix.homeModules.stylix
                nixvim.homeModules.nixvim
              ];
              home-manager.users.ozen = import ./home/ozen/home.nix;
            }
          ];
        };
        steve = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = { inherit inputs outputs system; };
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-4
            ./hosts/steve
          ];
        };
        orlane = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs system; };
          modules = [
            ./hosts/orlane
          ];
        };
      };
    };
}
