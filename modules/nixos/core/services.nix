{

	flake.modules.nixos.services =
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

			displayManager = {
				noctalia-greeter = {
					enable = true;
					settings = {
						cursor.size = 24;
						keyboard.layout = "us";
					};
					cursorTheme = {
						package = pkgs.bibata-cursors;
						name = "Bibata-Modern-Ice";
					};
					settings = {
						appearance = {
							scheme = "Synced";
							theme_mode = "light";
						};
					};
				};
				sddm.enable = lib.mkForce false;
				gdm.enable = lib.mkForce false;
			};
		};
	};
}
