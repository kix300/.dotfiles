{config, pkgs, ... }:
{
  home.file."~/.config/hypr/hyprpaper.conf".text = ''
    preload = ~/Downloads/frieren-ultrawide-5040x2160-15153.jpg
    wallpaper = eDP-1,~/Downloads/frieren-ultrawide-5040x2160-15153.jpg
    splash = false

    #fully disable ipc
    # ipc = one
    '';
}
