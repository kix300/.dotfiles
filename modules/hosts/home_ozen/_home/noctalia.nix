{ _ , ... }:
{
	programs.noctalia = {
		enable = true;
		settings = {
			bar.default = {
				end = [ "tray" "notifications" "network" "bluetooth" "volume" "control-center" ];
				start = [ "workspaces" "group:g1" ];
				capsule_group = {
					accordion = false;
					accordion_direction = "end";
					enabled = true;
					fill = "surface_variant";
					id = "g1";
					members = [ "cpu" "temp" "ram" ];
					opacity = 1.0;
					padding = 6.0;
				};


			};
			lockscreen_widgets = {
				enabled = false;
				schema_version = 2;
				widget_order = [ "lockscreen-login-box@HDMI-A-1" ];
				grid = {
					cell_size = 16;
					major_interval = 4;
					visible = true;
				};
				widget."lockscreen-login-box@HDMI-A-1" = {
					box_height = 70.0;
					box_width = 400.0;
					cx = 960.0;
					cy = 961.0;
					output = "HDMI-A-1";
					rotation = 0.0;
					type = "login_box";
					settings = {
						background_color = "surface_variant";
						background_opacity = 0.88;
						background_radius = 12.0;
						input_opacity = 1.0;
						input_radius = 6.0;
						show_caps_lock = true;
						show_keyboard_layout = true;
						show_login_button = true;
					};
				};

			};
			nightlight = {
				enabled = true;
				force = true;
				temperature_day = 7500;
				temperature_night = 5100;
			};
			osd.kind = {
				media = false;
			};
			shell.session.actions = [
				{
					action = "lock";
					countdown_seconds = 0.0;
					enabled = true;
					shortcut = "1";
					variant = "default";
				}
				{
					action = "reboot";
					countdown_seconds = 0.0;
					enabled = true;
					shortcut = "2";
					variant = "default"; 
				}
				{
					action = "shutdown";
					countdown_seconds = 0.0;
					enabled = true;
					shortcut = "3";
					variant = "destructive";
				}
				{
					action = "logout";
					countdown_seconds = 0.0;
					enabled = false;
					shortcut = "2";
					variant = "default";
				}
				{
					action = "lock_and_suspend";
					countdown_seconds = 0.0;
					enabled = false;
					shortcut = "3";
					variant = "default";
				}
			];
			theme = {
				builtins = "Catppuccin";
				community_palett = "Oxocarbon";
				mode = "light";
				wallpapers_scheme = "m3-content";
				templates.builtin_ids = [ "alacritty" "ghostty" "hyprland" "kitty" "qt" ];
			};

			wallpaper = {
				directory = "/home/ozen/.dotfiles/commons/wallpapers";
				default.path = "/home/ozen/.dotfiles/commons/wallpapers/snow-mountains-5120x3413-26362.jpg";
				last.path = "/home/ozen/.dotfiles/commons/wallpapers/snow-mountains-5120x3413-26362.jpg";
				monitors.HDMI-A-1.path = "/home/ozen/.dotfiles/commons/wallpapers/snow-mountains-5120x3413-26362.jpg";
			};

		};
	};
}
