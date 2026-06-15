{ ... }:

{
	imports = [
		./hardware-configuration.nix
		../../commons/src/default.nix
		# ../../commons/src/nvidia.nix
		../../commons/src/prepkgs.nix
	];

	services = {
		displayManager.sddm.enable = false;
		displayManager.gdm.enable = false;
		xserver.displayManager.lightdm.enable = false;
		printing.enable = true;
		asusd.enable = true;
		power-profiles-daemon.enable = true;
	};

	nixpkgs.config.allowUnfree = true;
	users.users."meptik" = {
		isNormalUser = true;
		description = "Meptik";
		extraGroups = [ "networkmanager" "wheel" ];
		# packages = with pkgs; [
		# ];

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
}
