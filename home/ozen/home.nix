{ pkgs, ... }:
{
  imports = [
    ./../commons/Hcommons.nix
  ];
  programs.home-manager.enable = true;
  home = {
    username = "ozen";
    homeDirectory = "/home/ozen";
  };

  # pour creer un fichier xdg desktop portal hyprland et donc screensharing
  systemd.user.services.xdg-desktop-portal-hyprland = {
    Unit = {
      Description = "XDG Desktop Portal Hyprland";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.impl.portal.desktop.hyprland";
      ExecStart = "${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "
  ${builtins.readFile ./../../commons/hypr/hyprland/hyprland.conf}
  ";
  };
  home.stateVersion = "23.11";
}
