{ pkgs, ... }:
{
	imports = [
		./../../commons/stylix.nix
		./../../commons/nixvim/nixvim.nix
		./../../commons/wlogout.nix
	];

	services.vicinae = {
		enable = true;
	};
	home.pointerCursor = {
		gtk.enable = true;
		x11.enable = true;
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
		size = 24;
	};
	programs = {
		lazygit.enable = true;
		firefox.enable = true;
		ashell = {
			enable = true;
			settings = {
				modules = {
					center = [
						"Clock"
						"Window Title"
					];
					left = [
						"Workspaces"
						"Tray"
						"Media Player"
					];
					right = [
						"SystemInfo"
						[
							"Privacy"
							"Settings"
						]
					];
				};
				workspaces = {
					visibility_mode = "All";
				};
				window_title ={
					mode ="Title";
				};
				appearance = {
					scale_factor = 1.4;
					style = "Solid";
					opacity = 0.8;
					success_color = "#a6e3a1";
					text_color = "#cdd6f4";
					workspace_colors = [
						"#fab387"
						"#b4befe"
						"#cba6f7"
					];
					primary_colors = {
						base = "#fab387";
						text = "#1e1e2e";
					};
					danger_color = {
						base = "#f38ba8";
						weak = "#f9e2af";
					};
					background_color = {
						base = "#1e1e2e";
						weak = "#313244";
						strong = "#45475a";
					};
					secondary_color = {
						base = "#11111b";
						strong = "#1b1b25";
					};
				};
			};
		};
		git = {
			enable = true;
			settings.user.name = "kix300";
			settings.user.email = "kixwalkiki@gmail.com";
		};
		yazi = {
			enable = true;
			shellWrapperName = "y";
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
