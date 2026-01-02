{ ... }:
{
  imports = [
    ./../../commons/stylix.nix
    ./../../commons/nixvim/nixvim.nix
    ./../../commons/wlogout.nix
  ];

  # services.vicinae = {
  #   enable = false;
  #   autoStart = false;
  # };
  programs = {
    lazygit.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      settings.user.name = "kix300";
      settings.user.email = "kixwalkiki@gmail.com";
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
         				alias nswitch="rm ~/.gtkrc-2.0 && nh os switch"
         				alias dofus="appimage-run ~/Games/DOFUS/Ankama\ Launcher-Setup-x86_64.AppImage"
         				alias zed="zeditor ."
         				function =
        					yazi $argv
         				end
         				bind \c] =

         				function nvimfiles
        					nvim ~/.dotfiles
         				end

         				bind alt-] nvimfiles
        			'';
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
		icon_theme = "Colored Zed Icons Theme Dark";
        relative_line_numbers = true;
        assistant = {
          enabled = true;
          version = "2";
          default_open_ai_model = null;
          default_model = {
            provider = "copilot_chat";
            model = "claude-4-sonnet-latest";
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
          rust-analyzer = {
            binary = {
              path = "/run/current-system/sw/bin/rust-analyzer";
            };
          };
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
            formatter = {
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
        load_direnv = "shell_hook";
        base_keymap = "VSCode";
        show_whitespaces = "all";
        theme = {
          dark = "Terafox - blurred";
          light = "Terafox - blurred";
        };

      };

    };

  };

  home.stateVersion = "23.11";
}
