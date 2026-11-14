{
pkgs,
...
}:
{

	fileSystems."/mnt/bob" =
	{ device = "/dev/disk/by-uuid/0947a22a-329d-432a-9db6-c71138e5d872";
		fsType = "ext4";
		options = [
			"users" "rw" "exec" "relatime"
		];
	};
	#discord
	nixpkgs.config.permittedInsecurePackages = [
		"electron-38.8.4"
	];
	networking = {
		hostName = "ozen_home";
		hosts = {
			"192.168.1.52" = [ "forgejo.kix.lab" ];
		};
	};

	boot.loader = {
		grub = {
			enable = true;
			device = "/dev/sda";
		};
	};
	#env variable for guitar plugin
	environment.variables = {
		LV2_PATH = [
			"$HOME/.lv2"
			"$HOME/.nix-profile/lib/lv2"
			"/etc/profiles/per-user/ozen/lib/lv2"
			"/run/current-system/sw/lib/lv2"
		];
	};
	services.xserver.videoDrivers = [ "nvidia" "nvidia_drm" "nvidia_modeset" ];
	hardware = {

		nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
		enableRedistributableFirmware = true;
		graphics.enable = true;
		nvidia.open = false;
	};
	boot = {
		kernelModules = [
			"rtl88x2bu"
			"ucsi_ccg"
		];
		kernelParams = [
			"iwlwifi.11ax_disable=0" # Active le Wi-Fi 6 (802.11ax)
			"iwlwifi.power_save=0" # Désactive l'économie d'énergie (peut améliorer les perfs)
			#should fix crash nvidia msi 1070
			"pcie_aspm=off"
			"pcie_port_pm=off"

		];
	};

}
