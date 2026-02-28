{
	pkgs,
	...
}:
{

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
}
