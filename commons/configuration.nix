{ pkgs, ... }:

{
	imports = [
		./prepkgs.nix
	];
	environment.variables.EDITOR = "nvim";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};
	programs = {
		hyprland.portalPackage = true;
		hyprland.xwayland.enable = true;
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
		adb.enable = true;
		steam = {
			enable = false;
			extest.enable = false;
		};
	};

	i18n = {
		defaultLocale = "en_US.UTF-8";
	};

	virtualisation = {
		virtualbox = {
			host.enable = true;
			host.enableExtensionPack = true;
			guest.enable = true;
			guest.dragAndDrop = true;
		};
	};
}
