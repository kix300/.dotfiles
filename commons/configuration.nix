{ pkgs, ... }:

{
	imports = [
		./prepkgs.nix
	];
	environment.variables.EDITOR = "nvim lazygit";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

	services = {
		udev.enable = true;
		gvfs.enable = true;
		supergfxd.enable = true;
		printing.enable = true;
		upower.enable = true;
		blueman.enable = true;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
	};
	hardware = {
		i2c.enable = true;
		bluetooth.enable = true;
		bluetooth.powerOnBoot = true;
		graphics = {
			enable = true;
		};
	};

	time.timeZone = "Europe/Paris";

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LC_ADDRESS = "fr_FR.UTF-8";
			LC_IDENTIFICATION = "fr_FR.UTF-8";
			LC_MEASUREMENT = "fr_FR.UTF-8";
			LC_MONETARY = "fr_FR.UTF-8";
			LC_NAME = "fr_FR.UTF-8";
			LC_NUMERIC = "fr_FR.UTF-8";
			LC_PAPER = "fr_FR.UTF-8";
			LC_TELEPHONE = "fr_FR.UTF-8";
			LC_TIME = "fr_FR.UTF-8";
		};
	};


	security = {
		rtkit.enable = true;
		polkit.enable = true;
		pam = {
			services = {
				swaylock = { };
				hyprlock = { };
			};
		};
	};


	programs = {
		hyprland.portalPackage = true;
		hyprland.xwayland.enable = true;
		ssh.startAgent = true;
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
		adb.enable = true;
		steam = {
			enable = true;
			extest.enable = true;
		};
	};

	virtualisation = {
		virtualbox = {
			host.enable = false;
			host.enableExtensionPack = false;
			guest.enable = false;
			guest.dragAndDrop = false;
		};
	};

	fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
		nerd-fonts.fira-code
	];
}
