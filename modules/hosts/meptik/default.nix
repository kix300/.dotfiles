{ lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
		../../commons/src/default.nix
		../../commons/src/nvidia.nix
		../../commons/src/prepkgs.nix
	];

	services = {
		displayManager.sddm.enable = false;
		displayManager.gdm.enable = false;
		xserver.displayManager.lightdm.enable = true;
		printing.enable = true;
		asusd.enable = true;
		xserver = {
			enable = true;
			xkb = {
				layout = lib.mkForce "fr";
				variant = lib.mkForce "";
			};
		};
		power-profiles-daemon.enable = true;
	};
	i18n = {
		defaultLocale = lib.mkForce "fr_FR.UTF-8";
	};
	console.keyMap = lib.mkForce "fr";
	nixpkgs.config.allowUnfree = true;
	users.users."meptik" = {
		isNormalUser = true;
		description = "Meptik";
		extraGroups = [
			"networkmanager"
			"wheel"
		];
		packages = with pkgs; [
			python3
			prismlauncher
		];

	};

	programs = {
		steam = {
			enable = true;
			gamescopeSession.enable = true;
		};
	};

	networking = {
		hostName = "laptop_meptik";
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
	# ASUS TUF FX506LI OPENRGB
	hardware.i2c.enable              = true;
	services.udev.packages           = [ pkgs.openrgb ];
	services.hardware.openrgb.enable = true;
	boot = {
		# remove this broken packages i guess ive added it for some wifi problem that come from my box
		# extraModulePackages = with config.boot.kernelPackages; [ rtl8812au ];
		kernelModules = [
			"i2c-dev"
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
}
