{
...
}:

{
	imports = [
		./hardware-configuration.nix
		../../commons/common.nix
		../../commons/nvidia.nix
		./packages.nix
		./services.nix
		./programs.nix
		./other.nix
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
	environment.variables = {
		LV2_PATH = [
			"$HOME/.lv2"
			"$HOME/.nix-profile/lib/lv2"
			"/etc/profiles/per-user/ozen/lib/lv2"
			"/run/current-system/sw/lib/lv2"
		];
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
	system.stateVersion = "23.05"; # Did you read the comment?

}
