{ pkgs, ... }:
{
	programs = {
		firefox.enable = true;
		dconf.enable = true;
		xfconf.enable = true;
		bash = {
			interactiveShellInit = ''
						if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
							then
								shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
								exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
								fi
			'';
		};
		nh = {
			enable = true;
			clean.enable = true;
			clean.extraArgs = "--keep-since 4d --keep 3";
			flake = "/home/ozen/.dotfiles";
		};
		gnupg.agent = {
			enable = true;
			# enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-gnome3;
		};
		hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
		hyprland = {
			enable = true;
			withUWSM = true;
			xwayland.enable = true;
		};
		nix-ld.enable = true;
		direnv = {
			enable = true;
			package = pkgs.direnv;
			silent = false;
			loadInNixShell = true;
			direnvrcExtra = "";
			nix-direnv = {
				enable = true;
				package = pkgs.nix-direnv;
			};
		};
	};
}
