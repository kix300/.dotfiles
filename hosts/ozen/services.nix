{
	lib,
	pkgs,
	...
}:
{
	virtualisation = {
		libvirtd.enable = true;
		spiceUSBRedirection.enable = true;
	};
	systemd.services.libvirt-default-network = {
		description = "Start libvirt default network";
		after = ["libvirtd.service"];
		wantedBy = ["multi-user.target"];
		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
			ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
			ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
			User = "root";
		};
	};

	services = {
		thermald.enable = true;
		auto-cpufreq = {
			enable = false;
			settings = {
				battery = {
					governor = "powersave";
					turbo = "never";
				};
				charger = {
					governor = "performance";
					turbo = "auto";
				};
			};
		};
		logind.settings.Login = {
			HandlelidSwitch = "ignore";
			HandlelidSwitchDocked = "ignore";
			HandlelidSwitchExternalPower = "ignore";
			extraConfig = ''
				IdleAction=ignore
				IdleActionSec=0
			'';
		};
		power-profiles-daemon.enable = true;
		xserver = {
			enable = lib.mkForce false;
		};
		desktopManager.plasma6.enable = lib.mkForce false;
		displayManager.sddm.enable = lib.mkForce false;
		displayManager.gdm.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};

}
