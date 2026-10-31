{_, ...}:
{
	services = {
		udev.enable = true;
		gvfs.enable = true;
		supergfxd.enable = true;
		printing.enable = true;
		upower.enable = true;
		dbus.enable = true;
		blueman.enable = true;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			jack.enable = true;
			pulse.enable = true;
			wireplumber.enable = true;
		};
		libinput.enable = true;
		xserver = {
			enable = true;
			xkb = {
				layout = "us";
				variant = "";
			};
		};
	};
}
