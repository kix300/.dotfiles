{

	flake.modules.nixos.services =
	{ ... }:
	{
		services = {
			udev.enable = true;
			gvfs.enable = true;
			supergfxd.enable = true;
			printing.enable = true;
			upower.enable = true;
			dbus.enable = true;
			blueman.enable = true;
			libinput.enable = true;
		};
	};
}
