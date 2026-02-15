{
pkgs,
lib,
inputs,
...
}:

{
	imports = [
		./hardware-configuration.nix
		../../commons/configuration.nix
		../../commons/common.nix
		../../commons/nvidia.nix
	];

	networking = {
		hostName = "laptop";
		networkmanager.enable = true;
		wireless.iwd = {
			enable = false;
			settings = {
				General = {
					EnableNetworkConfiguration = true;
				};
				IPv6 = {
					Enabled = true;
				};
				Settings = {
					AutoConnect = true;
				};
			};
		};
	};
	nixpkgs.config.allowUnfree = true;
	users.extraGroups.vboxusers.members = [ "ozen wheel" ];
	users.users.ozen = {
		isNormalUser = true;
		description = "Killian";
		extraGroups = [
			"networkmanager"
			"wheel"
			"adbusers"
			"lp"
			"i2c"
			"docker"
			"video"
			"audio"
			"jackaudio"
		];
		packages = with pkgs; [
			aapt
			adbtuifm
			adwaita-icon-theme
			aircrack-ng
			android-tools
			apktool
			appimage-run
			ardour
			lsp-plugins
			gxplugins-lv2
			tamgamp-lv2
			neural-amp-modeler-lv2
			asusctl
			bear
			btop-cuda
			brightnessctl
			clang-tools
			comma
			cmake
			ddcui
			ddcutil
			direnv
			discord
			distrobox
			fd
			glfw
			godot
			guitarix
			gpu-screen-recorder
			hyprlock
			jack2
			kdePackages.qtsvg
			kdePackages.qtwayland
			kdePackages.qtdeclarative
			kitty
			lua
			lutris
			bottles
			lshw
			# n8n
			nil
			nodejs
			norminette
			ntfs3g
			obs-studio
			openjdk
			pavucontrol
			prismlauncher
			pulseaudio
			python3
			qjackctl
			r2modman
			revolt-desktop
			rofi-power-menu
			rofi
			signal-desktop
			spotify
			supabase-cli
			swaylock-fancy
			swww
			telegram-desktop
			util-linux
			vimPlugins.nvim-treesitter-parsers.qmljs
			wayvnc
			wine
			wofi
			thunar
			inputs.zen-browser.packages."${system}".default
			inputs.quickshell.packages."${system}".default
		];
	};
	environment.variables = {
		LV2_PATH = [
			"$HOME/.lv2"
			"$HOME/.nix-profile/lib/lv2"
			"/etc/profiles/per-user/ozen/lib/lv2"
			"/run/current-system/sw/lib/lv2"
		];
	};
	virtualisation = {
		podman.enable = true;
		docker = {
			enable = true;
			rootless = {
				enable = true;
				setSocketVariable = true;
			};
		};
		waydroid = {
			enable = true;
			package = pkgs.waydroid-nftables;
		};
	};

	services = {
		thermald.enable = true;
		auto-cpufreq = {
			enable = false;
			settings = {
				battery = {
					governor = "powersave";
					turbo = "never";
				};
				charger = {
					governor = "performance";
					turbo = "auto";
				};
			};
		};
		logind.settings.Login = {
			HandlelidSwitch = "ignore";
			HandlelidSwitchDocked = "ignore";
			HandlelidSwitchExternalPower = "ignore";
		};
		power-profiles-daemon.enable = true;
		xserver = {
			enable = lib.mkForce false;
		};
		displayManager.sddm.enable = lib.mkForce false;
		desktopManager.plasma6.enable = lib.mkForce false;
		displayManager.gdm.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};

	xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-hyprland
			pkgs.xdg-desktop-portal-gtk
		];
		configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
		config = {
			common = {
				default = [ "gtk" ];
			};
			hyprland = {
				default = [
					"hyprland"
					"gtk"
				];
				"org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
				"org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
			};
		};
	};

	systemd.user.services = {
		xdg-desktop-portal-hyprland = {
			enable = true;
			wantedBy = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
		};

		xdg-desktop-portal = {
			enable = true;
			wantedBy = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
		};
	};
	boot = {
		# remove this broken packages i guess ive added it for some wifi problem that come from my box
		# extraModulePackages = with config.boot.kernelPackages; [ rtl8812au ];
		kernelModules = [
			"8812au"
			"amdgpu.dc=1"
			"iwlwifi"
			"iwlmvm"
			"amdgpu"
			"ucsi_ccg"
		];
		kernelParams = [
			"iwlwifi.11ax_disable=0" # Active le Wi-Fi 6 (802.11ax)
			"iwlwifi.power_save=0" # Désactive l'économie d'énergie (peut améliorer les perfs)
		];
	};

	programs = {
		hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
		hyprland = {
			enable = true;
			withUWSM = true;
			xwayland.enable = true;
		};
		steam = {
			enable = true;
			gamescopeSession.enable = true;
		};
		gamescope = {
			enable = true;
			capSysNice = true;
		};
	};

	hardware.enableRedistributableFirmware = true;

	# hardware = {
	# 	nvidia = {
	# 		prime.offload.enable = lib.mkForce false;
	# 		prime.offload.enableOffloadCmd = lib.mkForce false;
	# 		prime.sync.enable = lib.mkForce false;
	# 		dynamicBoost.enable = lib.mkForce false;
	# 		modesetting.enable = lib.mkForce false;
	# 		powerManagement.enable = lib.mkForce false;
	# 		powerManagement.finegrained = lib.mkForce false;
	# 		nvidiaSettings = lib.mkForce false;
	# 		open = lib.mkForce false;
	# 	};
	# };
	# boot.extraModprobeConfig = ''
	# 			blacklist nouveau
	# 			options nouveau modeset=0
	# '';
	#
	# services.udev.extraRules = ''
	# 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
	# 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
	# 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
	# 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
	# '';
	# ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"

	# boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?

}
