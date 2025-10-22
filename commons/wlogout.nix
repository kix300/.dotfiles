{
  pkgs,
  config,
  ...
}:
let
  inherit (config.colorscheme) palette;
  myWlogout = pkgs.wlogout.overrideAttrs (
    final: prev: {
      nativeBuildInputs = prev.nativeBuildInputs ++ [
        pkgs.inkscape
      ];
      postUnpack = ''
        find source/assets -type f -name '*.svg' -exec sed -i -e 's/<path /<path style=\"fill:#${palette.base05}\" /g' {} +
        inkscape --export-type=png --export-width=96 source/assets/*.svg
        mv source/assets/*.png source/icons
      '';
    }
  );
in
{
  programs.wlogout = {
    enable = true;
    package = myWlogout;
    layout = [
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "loginctl lock-session; sleep 1; systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      window {
        background: rgba(0, 0, 0, 0.4);
      }

      button {
        color: #${palette.base05};
        background-color: #${palette.base00};
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: #${palette.base02};
        outline-style: none;
      }

      #lock {
        background-image: image(url("${myWlogout}/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
      }

      #logout {
        background-image: image(url("${myWlogout}/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
        background-image: image(url("${myWlogout}/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        background-image: image(url("${myWlogout}/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
        background-image: image(url("${myWlogout}/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        background-image: image(url("${myWlogout}/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
