{ config, lib, ... }:

let
  baseHostModule = import ./_utils/base.nix;
  homeManagerModule = import ./_utils/home-manager.nix;
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
              config.flake.modules.nixos.core
              { networking.hostName = name; }
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
      inherit (host) pkgs;
    }
  ) config.nixosHosts;
}
