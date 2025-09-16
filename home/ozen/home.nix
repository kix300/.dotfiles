{ pkgs, ... }:
{
  imports = [
    ./../../commons/stylix.nix
    ./../../commons/nixvim/nixvim.nix
    ./../../commons/waybar/waybar.nix
  ];
  programs.home-manager.enable = true;

  home = {
    username = "ozen";
    homeDirectory = "/home/ozen";

  };
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "
			${builtins.readFile ./../../commons/hypr/hyprland/hyprland.conf}
			";
  };

  programs = {
    lazygit.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      userName = "kix300";
      userEmail = "kixwalkiki@gmail.com";
    };
    yazi = {
      enable = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        				set fish_greeting # Disable greeting
        				eval "$(direnv hook fish)"
        				alias nswitch="rm ~/.gtkrc-2.0 && nh os switch"
        				alias dofus="appimage-run ~/Games/DOFUS/Ankama\ Launcher-Setup-x86_64.AppImage"
        				alias zed="zeditor ."
        				function =
        					yazi $argv
        				end
        				bind \c] =

        				function zedfiles
        					zeditor ~/.dotfiles
        				end

        				bind alt-] zedfiles
        			'';
    };
    ags = {
      enable = true;
      configDir = null;
      extraPackages = with pkgs; [
        accountsservice
      ];
    };
    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "make"
        "c++"
        "c"
        "qml"
      ];
      userSettings = {
        assistant = {
          enabled = true;
          version = "2";
          default_open_ai_model = null;
          default_model = {
            provider = "zed.dev";
            model = "claude-3-5-sonnet-latest";
          };
        };
        hour_format = "hour24";
        terminal = {
          alternate_scroll = "on";
          blinking = "off";
          copy_on_select = false;
          dock = "bottom";
          detect_venv = {
            on = {
              directories = [
                ".env"
                "env"
                ".venv"
                "venv"
              ];
              activate_script = "default";
            };
          };
          env = {
            TERM = "ghostty";
          };
          font_family = "FiraCode Nerd Font";
          font_features = null;
          font_size = null;
          line_height = "comfortable";
          option_as_meta = false;
          button = false;
          shell = "system";
          toolbar = {
            title = true;
          };
          working_directory = "current_project_directory";
        };
        lsp = {
          nix.binary.path_lookup = true;
          qml.binary.path_lookup = true;
          qml.binary.arguments = [
            "-E"
            "additional-args"
          ];
        };
        languages = {
          "qml" = {
            language_servers = [ "qmlls" ];
            format_on_save = {
              external = {
                command = "mix";
                arguments = [
                  "-E"
                  "additional-args"
                ];
              };
            };
          };
        };

        vim_mode = true;
        ## tell zed to use direnv and direnv can use a flake.nix enviroment.
        load_direnv = "shell_hook";
        base_keymap = "VSCode";
        show_whitespaces = "all";
        theme = {
          dark = "Everforest Dark Hard";
          light = "Everforest Dark Hard";
        };

      };

    };

  };

  home.stateVersion = "23.11";
}
