{ pkgs, ... }:
{
  imports = [
    ./../commmons/Hcommons.nix
  ];
  programs.home-manager.enable = true;

  home = {
    username = "Kix";
    homeDirectory = "/home/Kix";
  };

  home.stateVersion = "23.11";
}
