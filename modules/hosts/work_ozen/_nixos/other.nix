{ pkgs, lib, ... }:

{
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	services = {
		displayManager.sddm.enable = false;
		displayManager.gdm.enable = false;
		xserver.displayManager.lightdm.enable = false;
		printing.enable = true;
		asusd.enable = true;
		power-profiles-daemon.enable = true;
		logind.lidSwitch = "ignore";
	};

	nixpkgs.config.allowUnfree = true;
	users.users."ozen_work" = {
		isNormalUser = true;
		description = "ozen_work";
		extraGroups = [
			"networkmanager"
				"wireshark"
				"wheel"
				"docker"
				"video"
				"audio"
				"libvirtd"
				"kvm"
		];
		packages = with pkgs; [
			xwayland-satellite
				xwayland
				nautilus
				wireshark
				kdePackages.kpeople
				glib
				sshfs
		];

	};

	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	xdg.portal = {
		config = {
			niri = lib.mkForce {
				default = [ "gtk" ];
				"org.freedesktop.impl.portal.Settings" = "gtk";
				"org.freedesktop.impl.portal.FileChooser" = "gtk";
				"org.freedesktop.impl.portal.ScreenCast" = "gnome";
				"org.freedesktop.impl.portal.Screenshot" = "gnome";
			};
		};
	};


	networking = {
		hostName = "laptop_work";
		hosts = {
			"192.168.1.52" = [ "forgejo.kix.lab" ];
			"127.0.0.1" = [ "grafana.lgtm.local" ]; #lgtm
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
