{pkgs, ...}:
{
	imports = [
		#./hypr/hyprland.nix
		#./hypr/hyprpaper.nix
		./stylix.nix
		./nixvim/nixvim.nix
	];
	programs.home-manager.enable = true;

	home = {
		username = "ozen";
		homeDirectory = "/home/ozen";
		packages = with pkgs; [
			lshw
			asusctl
			pavucontrol
			ncspot
			spotify
			mangohud
			fish
		];
	};
	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = "
			${builtins.readFile ./hypr/hyprland/hyprland.conf}
		";
	};

	programs = {
		lazygit.enable = true;
		git = {
			enable = true;
			userName = "kix300";
			userEmail = "kixwalkiki@gmail.com";
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
				alias shell="nix-shell ~/.dotfiles/shell.nix"
				alias nswitch="rm ~/.gtkrc-2.0 && nh os switch"
				alias dofus="appimage-run ~/Games/DOFUS/Ankama\ Launcher-Setup-x86_64.AppImage"
				'';
		};
		ags = {
			enable = false;
			configDir = null;
			extraPackages = with pkgs; [
					accountsservice
			];
		};
	};
programs.waybar = {
	enable = true;
	settings = {
		mainBar = {
			layer = "top";
			position = "top";
			height = 32;
			output = [
				"eDP-1"
					"HDMI-A-1"
			];
			modules-left = [ "hyprland/workspaces" ];
			modules-center = [ "clock" ];
			modules-right = [ "network" "pulseaudio" "backlight" "temperature" "battery" ];

			"hyprland/workspaces" = {
				disable-scroll = true;
				all-outputs = true;
			};

			"clock" = {
				format = "{:%H:%M}";
				max-lenght = 25;
			};

			"network" = {
				format-wifi = " ";
				format-disconnected = "";
			};

			"pulseaudio" = {
				format = "{volume}% {icon}";
				format-bluetooth = "{volume}% {icon} ";
				format-muted = "";
				format-icons = {
					headphone = "";
					default = ["" ""];
				};
				scroll-step = 1;
				on-click = "pavucontrol";
			};

			"temperature" = {
				format = "{temperatureC}°C "; 
			};

			"battery" = {
				interval = 10;
				format = "{capacity}% {icon}";
				format-charging = "{capacity}% 󰂄";
				format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
			};
			"backlight" = {
				format = "{percent}% {icon}";
				format-icons = ["" ""];
			};
		};
	};
	style = "
		* {
border: none;
	border-radius: 0;
	font-size: 17px;
		}
	window#waybar {
		background-color: transparent;
color: white;
	}
#workspaces button, #taskbar button {
padding: 0 5px;
background: transparent;
color: white;
}
#workspaces button.focused, #taskbar button.focused { 
	background-color: transparent;
}
#battery, #temperature, #clock, #network, #backlight, #pulseaudio {
padding: 0 10px;
}
";
};

home.stateVersion = "23.11";
}
