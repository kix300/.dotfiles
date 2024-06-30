{config, pkgs, ... }:
{

  wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
      extraConfig = ''
        monitor=,preferred,auto,1.0

        exec-once = waybar
        exec-once = hyprpaper

        $terminal = kitty
        $fileManager = dolphin
        $menu = rofi -show drun
        $lock = swaylock-fancy
        $power = bash ~/.dotfiles/rofi/powermenu.sh

        env = XCURSOR_SIZE,24
        env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that

        input {
          kb_layout = us
          kb_variant = alt-intl
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
            disable_while_typing = true
            natural_scroll = yes
          }

          sensitivity = 0.2 # -1.0 to 1.0, 0 means no modification.
        }

      general {

        gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle

          allow_tearing = false
      }

      decoration {

        rounding = 10

          blur {
            enabled = true
              size = 6
              passes = 3
              new_optimizations = true
              xray = true
              ignore_opacity = true
          }

        drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
        enabled = yes

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
		new_status = master
      }

      gestures {
        workspace_swipe = on
          workspace_swipe_distance = 200
          workspace_swipe_min_speed_to_force = 0
      }

      misc {
        force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
      }

      device {
        name = epic-mouse-v1
          sensitivity = -0.5
      }

      windowrulev2 = suppressevent maximize, class:.*


        $mainMod = SUPER

        bind = $mainMod, Q, exec, $terminal
        bind = $mainMod, C, killactive, 
        bind = $mainMod, M, exit, 
        bind = $mainMod, E, exec, $fileManager
        bind = $mainMod, V, togglefloating, 
        bind = $mainMod, R, exec, $menu
        bind = $mainMod, P, pseudo, # dwindle
        bind = $mainMod, J, togglesplit, # dwindle
        bind = $mainMod, F, fullscreen, 1,
        bind = $mainMod, L, exec, $lock
        bind = $mainMod, X, exec, $power


        bind = $mainMod, A, movefocus, l
        bind = $mainMod, D, movefocus, r
        bind = $mainMod, W, movefocus, u
        bind = $mainMod, Z, movefocus, d

        bind = $mainMod SHIFT, A, movewindow, l
        bind = $mainMod SHIFT, D, movewindow, r
        bind = $mainMod SHIFT, W, movewindow, u
        bind = $mainMod SHIFT, Z, movewindow, d

        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        bind = $mainMod, S, togglespecialworkspace, magic
        bind = $mainMod SHIFT, S, movetoworkspace, special:magic

        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        bindel=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bindel=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

        bindel=, XF86MonBrightnessDown, exec, brightnessctl set 5%-
        bindel=, XF86MonBrightnessUp, exec, brightnessctl set 5%+
        bindel=, XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-
        bindel=, XF86KbdBrightnessUp,   exec, brightnessctl -d asus::kbd_backlight set 1+
        '';
  };
}
