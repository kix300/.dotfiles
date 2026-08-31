{ pkgs, lib, ... }:

{
	imports = [
		./hardware-configuration.nix
			../../commons/src/default.nix
			../../commons/src/virtualisation/virtualbox.nix
	];

	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	services = {
		displayManager.sddm.enable = false;
		displayManager.gdm.enable = false;
		xserver.displayManager.lightdm.enable = false;
		printing.enable = true;
		asusd.enable = true;
		power-profiles-daemon.enable = true;
	};

	nixpkgs.config.allowUnfree = true;
	users.users."ozen_work" = {
		isNormalUser = true;
		description = "ozen_work";
		extraGroups = [ "libvirtd" "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [
			slack
				alacritty
				kitty
				zellij
				wezterm
				cinny-desktop
				xwayland-satellite
				xwayland
				nautilus
		];

	};

	programs = {
		hyprland = {
			enable = lib.mkForce false;
			withUWSM = lib.mkForce true;
			xwayland.enable = lib.mkForce false;
		};

		niri = {
			enable = true;
			useNautilus = true;
		};
		regreet = {
			enable = false;
			settings = {
				background = {
					path = "~/.dotfiles/commons/wallpapers/whale.jpg";
					fit = "Cover";
				};
			};
		};
	};
	xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
		config = {
			common = {
				default = [ "gtk" ];
			};
			niri = lib.mkForce {
				default = [ "gtk" ];
				"org.freedesktop.impl.portal.Settings" = "gtk";
				"org.freedesktop.impl.portal.FileChooser" = "gtk";
			};
		};
	};


	networking = {
		hostName = "laptop_work";
		networkmanager.enable = true;
		wireless.iwd = {
			enable = false;
			settings = {
				General = {
					EnableNetworkConfiguration = true;
				};
				IPv6 = {
					Enabled = false;
				};
				Settings = {
					AutoConnect = false;
				};
			};
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
	hardware.enableRedistributableFirmware = true;
# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "26.05"; # Did you read the comment?

}
