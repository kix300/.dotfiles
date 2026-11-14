{ inputs, lib }:

{ config, ... }:
{
  options = {
    system = lib.mkOption {
      type = lib.types.str;
      default = "x86_64-linux";
    };

    unstable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    modules = lib.mkOption {
      type = with lib.types; listOf deferredModule;
      default = [ ];
    };

    tags = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
    };

    primaryUser = lib.mkOption {
      type = lib.types.str;
      default = "ozen";
    };

    specialArgs = lib.mkOption {
      type = with lib.types; attrsOf anything;
      default = { };
    };

    pkgs = lib.mkOption {
      type = lib.types.pkgs;
    };
  };

  config = {
    pkgs = import inputs.nixpkgs {
      inherit (config) system;
      config.allowUnfree = true;
    };

    specialArgs = {
      inherit inputs;
      inherit (config) primaryUser;
    };
  };
}
