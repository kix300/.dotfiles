{config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = ["~/Pictures/wallpaper.png"];
      wallpaper = [
        "eDP-1, ~/Pictures/wallpaper.png"
        "HDMI-A-1, ~/Pictures/wallpaper.png"
      ];
    };
  };
}
