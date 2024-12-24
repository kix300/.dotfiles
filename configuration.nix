{ config, pkgs, lib, ... }:

{
	imports =
		[
			./hardware-configuration.nix
			#./hypr/hyprland.nix
			#./nvidia.nix
		];

	environment.variables.EDITOR = "nvim lazygit";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;


	services = {
		xserver = {
			xkb = {
				layout = "us";
				variant = "";
			};
			enable = true;
			videoDrivers = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ]; # or "nvidiaLegacy470 etc.
		};
		udev.enable = true;
		displayManager.sddm.enable = true;
		desktopManager.plasma6.enable = true;
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
		nvidia.open = lib.mkDefault true;
		i2c.enable = true;
		bluetooth.enable = true;
		bluetooth.powerOnBoot = true;
	};


	hardware.nvidia = {
		prime.offload.enable = lib.mkDefault true;
		prime.offload.enableOffloadCmd = lib.mkDefault true;
		prime.sync.enable = lib.mkForce false;
		dynamicBoost.enable = lib.mkDefault true;
		modesetting.enable = lib.mkDefault true;
		powerManagement.enable = lib.mkDefault true;
		powerManagement.finegrained = lib.mkDefault true;
		nvidiaSettings = lib.mkDefault true;
	};
	/*
*/

	networking = {
		hostName = "OzenOs";
		wireless.iwd = {
			enable = true;
			settings = {
				IPv6 = {
					Enabled = true;
				};
				Settings = {
					AutoConnect = true;
				};
			};
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


	users.extraGroups.vboxusers.members = [ "ozen wheel" ];
	users.users.ozen = {
		isNormalUser = true;
		description = "Killian";
		extraGroups = [ "networkmanager" "wheel" "adbusers" "lp" "i2c" ];
		packages = with pkgs; [
			kate
		];
	};
	programs = {
		hyprland.portalPackage = true;
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
			host.enable = true;
			guest.enable = true;
		};
	};

	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		aapt
		adbtuifm
		adwaita-icon-theme
		aircrack-ng
		android-tools
		apktool
		appimage-run
		binutils
		brightnessctl
		comma
		ddcui
		ddcutil
		direnv
		discord-screenaudio
		dolphin
		firefox-devedition
		git
		gnumake
		grim
		helix
		heroic
		hyprlock
		iwgtk
		kdePackages.qtsvg
		kdePackages.qtwayland
		kitty
		libbsd
		libgcc
		libgccjit
		neovim
		nil
		nodejs
		norminette
		ntfs3g
		openjdk
		prismlauncher
		qbittorrent
		qt6ct
		readline
		readline70
		rocmPackages_5.llvm.clang
		rofi-power-menu
		rofi-wayland
		rpi-imager
		signal-desktop
		swaylock-fancy
		telegram-desktop
		util-linux
		valgrind
		vscodium
		wine
		wofi
		xdg-desktop-portal-gtk
		xdg-desktop-portal-hyprland
		xfce.thunar
	];

	fonts.packages = with pkgs; [
		fira-code
		fira-code-symbols
		nerd-fonts.fira-code
	];


	specialisation = {
		WORK_NOT_KDE.configuration = {
			environment.etc."specialisation".text = "WORK_NOT_KDE";
			services = {
				xserver = {
					enable = lib.mkForce false;
					videoDrivers = [ "nouveau" "nvidia_drm" "nvidia_modeset" ]; # or "nvidiaLegacy470 etc.
				};
				displayManager.sddm.enable = lib.mkForce false;
				desktopManager.plasma6.enable = lib.mkForce false;
			};
			system.nixos.tags = [ "without_nvidia" ];

			hardware.nvidia = {
				prime.offload.enable = lib.mkForce false;
				prime.offload.enableOffloadCmd = lib.mkForce false;
				prime.sync.enable = lib.mkForce false;
				dynamicBoost.enable = lib.mkForce false;
				modesetting.enable = lib.mkForce false;
				powerManagement.enable = lib.mkForce false;
				powerManagement.finegrained = lib.mkForce false;
				nvidiaSettings = lib.mkForce false;
				open = lib.mkForce false;
			};
			qt.enable = false;
			boot.extraModprobeConfig = ''
								blacklist nouveau
								options nouveau modeset=0
			'';

			services.udev.extraRules = ''
				# Remove NVIDIA USB xHCI Host Controller devices, if present
								ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
				# Remove NVIDIA USB Type-C UCSI devices, if present
								ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
				# Remove NVIDIA Audio devices, if present
								ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
				# Remove NVIDIA VGA/3D controller devices
								ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
			'';
			boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
		};
	};
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?

}
