{ config, pkgs, ... }:

{
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "kiki";
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	time.timeZone = "Europe/Paris";


	i18n.extraLocaleSettings = {
		defaultLocale = "en_US.UTF-8";
		LC_ADDRESS = "fr_FR.UTF-8";
		LC_IDENTIFICATION = "fr_FR.UTF-8";
		LC_MEASUREMENT = "fr_FR.UTF-8";
		LC_MONETARY = "fr_FR.UTF-8";
		LC_NAME = "fr_FR.UTF-8";
		LC_NUMERIC = "fr_FR.UTF-8";
		LC_PAPER = "fr_FR.UTF-8";
		LC_TELEPHONE = "fr_FR.UTF-8";
		LC_TIME = "fr_FR.UTF-8";
	};

	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	services.pulseaudio.enable = false;

	users.users.kiki = {
		isNormalUser = true;
		description = "kiki";
		extraGroups = [ "networkmanager" "wheel" ];
	};

	virtualisation = {
		virtualbox = {
			guest = {
				enable = false;
				dragAndDrop = false;
			};
		};
	};
	nixpkgs.config.allowUnfree = true;

}
