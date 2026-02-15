{ pkgs, ... }:

{
	imports = [
		./prepkgs.nix
	];
	environment.variables.EDITOR = "nvim";
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];
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
			jack.enable = true;
			pulse.enable = true;
			wireplumber.enable = true;
		};
		libinput.enable = true;
		xserver = {
			enable = true;
			xkb = {
				layout = "us";
				variant = "";
			};
		};
	};
	console.useXkbConfig = true;
	hardware = {
		i2c.enable = false;
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
		nh = {
			enable = true;
			clean.enable = true;
			clean.extraArgs = "--keep-since 4d --keep 3";
			flake = "/home/ozen/.dotfiles";
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
		pnpm
		valgrind
		util-linux

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
		polkit.extraConfig = ''
	polkit.addRule(function(action, subject) {
	  if (action.id == "org.freedesktop.policykit.exec" &&
		  action.lookup("program") == "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server" &&
		  subject.isInGroup("video")) {
		return polkit.Result.YES;
	  }
	});
		'';
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
