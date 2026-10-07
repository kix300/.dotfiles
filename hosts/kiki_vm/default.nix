{ config, pkgs, ... }:

{
	imports =
		[
		./hardware-configuration.nix
		../../commons/src/programs.nix
		../../commons/src/packages.nix
		];

	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "kiki";
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	networking.networkmanager.enable = true;

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

	services.xserver.enable = true;

	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	services.printing.enable = true;

	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	users.users.kiki = {
		isNormalUser = true;
		description = "kiki";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			kdePackages.kate
		];
	};

	virtualisation = {
		virtualbox = {
			guest = {
				enable = false;
				dragAndDrop = false;
			};
		};
	};
	programs.firefox.enable = true;

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		fish
	];

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?

}
