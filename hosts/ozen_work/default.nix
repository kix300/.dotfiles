{ ... }:

{
	imports = [
		./hardware-configuration.nix
		../../commons/src/default.nix
	];
# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	services.displayManager.sddm.enable = false;
	services.displayManager.gdm.enable = false;
	services.xserver.displayManager.lightdm.enable = false;

	nixpkgs.config.allowUnfree = true;
	users.users."ozen_work" = {
		isNormalUser = true;
		description = "ozen_work";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
	};

	services.printing.enable = true;


	virtualisation = {
		podman.enable = true;
		docker = {
			enable = true;
			rootless = {
				enable = true;
				setSocketVariable = true;
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
					Enabled = true;
				};
				Settings = {
					AutoConnect = true;
				};
			};
		};
	};
# boot = {
# 	# remove this broken packages i guess ive added it for some wifi problem that come from my box
# 	# extraModulePackages = with config.boot.kernelPackages; [ rtl8812au ];
# 	kernelModules = [
# 		"8812au"
# 		"amdgpu.dc=1"
# 		"iwlwifi"
# 		"iwlmvm"
# 		"amdgpu"
# 		"ucsi_ccg"
# 	];
# 	kernelParams = [
# 		"iwlwifi.11ax_disable=0" # Active le Wi-Fi 6 (802.11ax)
# 		"iwlwifi.power_save=0" # Désactive l'économie d'énergie (peut améliorer les perfs)
# 	];
# };
	hardware.enableRedistributableFirmware = true;
}
