{ pkgs, lib, ... }:

{
	imports = [
		./hardware-configuration.nix
		../../commons/src/default.nix
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
	users.users."ozen_work" = {
		isNormalUser = true;
		description = "ozen_work";
		extraGroups = [ "libvirtd" "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [
			slack
		];

	};
#test niri so remove hyprland
	programs.hyprland = {
		enable = lib.mkForce false;
		withUWSM = lib.mkForce true;
		xwayland.enable = lib.mkForce false;
	};

	#niri conf in home-manager : xdg.configFile."niri/config.kdl".source = niri/config.kdl;
	#after the conf create add to HM to modify  config file and add it to dotfile
	programs.niri.enable = true;
	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.niri}/bin/niri-session";
				user = "ozen_work";
			};
		};
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
