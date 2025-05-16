
{ pkgs, ... }:

{
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

	programs = {
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
	};

	environment.systemPackages = with pkgs; [
		vim
		fish
		clang
		clang-tools
		git
		gnumake
		ghostty
		grim
		iwgtk
		libbsd
		libclang
		libgcc
		libgccjit
		lutris
		pnpm
		readline
		readline70
		valgrind
		vscodium
	];

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

	fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
		nerd-fonts.fira-code
	];
}
