
{config, pkgs, lib, inputs, ... }:

{
	imports =
		[		
			./hardware-configuration.nix
			../../commons/configuration.nix
			../../commons/common.nix
		];


	networking = {
		hostName = "laptop";
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
	nixpkgs.config.allowUnfree = true;
	users.extraGroups.vboxusers.members = [ "ozen wheel" ];
	users.users.ozen = {
		isNormalUser = true;
		description = "Killian";
		extraGroups = [ "networkmanager" "wheel" "adbusers" "lp" "i2c" "docker" ];
		packages = with pkgs; [
			lshw
			asusctl
			pavucontrol
			aapt
			adbtuifm
			adwaita-icon-theme
			aircrack-ng
			android-tools
			#android-studio
			apktool
			appimage-run
			bear
			brightnessctl
			clang-tools
			comma
			ddcui
			ddcutil
			direnv
			discord
			distrobox
			gemini-cli
			glfw
			godot
			heroic
			hyprlock
			#jadx
			kdePackages.qtsvg
			kdePackages.qtwayland
			kitty
			nil
			nodejs
			norminette
			ntfs3g
			obs-studio
			openjdk
			prismlauncher
			qbittorrent
			qt6ct
			rofi-power-menu
			rofi-wayland
			rpi-imager
			signal-desktop
			spotify
			supabase-cli
			swaylock-fancy
			telegram-desktop
			util-linux
			vscode
			wine
			wofi
			xdg-desktop-portal-gtk
			xdg-desktop-portal-hyprland
			xfce.thunar
			zed-editor
			inputs.zen-browser.packages."${system}".default
		];
	};
	virtualisation.podman.enable = true;
	virtualisation.docker.enable = true;
	virtualisation.docker.rootless = {
		enable = true;
		setSocketVariable = true;
	};

	# for charging phone
	services.logind = {
		lidSwitch = "ignore";
		lidSwitchDocked = "ignore";
		lidSwitchExternalPower = "ignore";
	};

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-hyprland
			pkgs.xdg-desktop-portal-gtk
		];
		configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
		config = {
			common.default = "*";
			hyprland = {
				default = [ "hyprland" "gtk" ];
			};
		};
	};
	boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8812au ];
	boot.kernelModules = [ "8812au" ];

	services = {
		xserver = {
			enable = lib.mkForce false;
		};
		displayManager.sddm.enable = lib.mkForce false;
		desktopManager.plasma6.enable = lib.mkForce false;
		displayManager.gdm.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};

	hardware = {
		nvidia = {
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
	};
	qt.enable = false;
	boot.extraModprobeConfig = ''
				blacklist nouveau
				options nouveau modeset=0
	'';

	services.udev.extraRules = ''
		ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"
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
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?

}
