{pkgs, ...}:
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
			'';
		};
		ags = {
			enable = true;
			configDir = null;
			extraPackages = with pkgs; [
				accountsservice
			];
		};
	};
	home.stateVersion = "23.11";
}
