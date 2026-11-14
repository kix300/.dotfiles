{ config, inputs, lib, ... }:

let
  baseHostModule = import ./_utils/base.nix { inherit inputs lib; };
  homeManagerModule = import ./_utils/home-manager.nix { inherit inputs lib; };
in
{
  options.nixosHosts = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule [
        baseHostModule
        homeManagerModule
        (
          { name, ... }:
          {
            modules = [
              { networking.hostName = lib.mkDefault name; }
            ];
          }
        )
      ]
    );
    default = { };
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    _name: host:
    lib.nixosSystem {
      inherit (host) system modules specialArgs;
    }
  ) config.nixosHosts;
}
