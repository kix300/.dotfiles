{ ... }:
{
  imports = [
    ./../commons/Hcommons.nix
  ];
  home = {
    username = "ozen";
    homeDirectory = "/home/ozen";
  };
  programs.home-manager.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "
  ${builtins.readFile ./../../commons/hypr/hyprland/hyprland.conf}
  ";
  };
  home.stateVersion = "23.11";
}
