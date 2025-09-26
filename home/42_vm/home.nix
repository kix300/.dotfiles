{ pkgs, ... }:
{
  imports = [
    ./../commons/Hcommons.nix
  ];

  home = {
    username = "kix";
    homeDirectory = "/home/kix";
  };

  home.stateVersion = "23.11";
}
