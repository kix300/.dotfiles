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
			#disable for now because of deprecated jack cause of impurity in ld_lib_path 
			jack.enable = false;
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
