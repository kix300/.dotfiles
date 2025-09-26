{ pkgs, ... }:
{
  imports = [
    ./../commons/Hcommons.nix
  ];
  home = {
    username = "ozen";
    homeDirectory = "/home/ozen";
  };

  home.stateVersion = "23.11";
}
