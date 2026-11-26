
{ _ , ... }:

{

	services = {
		xserver.xkb = {
			layout = "us";
			variant = "";
		};

		printing.enable = true;

		pulseaudio.enable = false;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = false;
	};
}
