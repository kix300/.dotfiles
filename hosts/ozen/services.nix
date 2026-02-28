{
	lib,
	...
}:
{
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
		};
		power-profiles-daemon.enable = true;
		xserver = {
			enable = lib.mkForce false;
		};
		displayManager.sddm.enable = lib.mkForce false;
		desktopManager.plasma6.enable = lib.mkForce false;
		displayManager.gdm.enable = lib.mkForce false;
		desktopManager.gnome.enable = lib.mkForce false;
	};

}
