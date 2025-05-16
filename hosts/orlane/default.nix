{ ... }:

{
	imports =
		[
			./hardware-configuration.nix
			../../commons/common.nix
		];

	nix.settings.experimental-features = [ "flakes" ];
	boot.loader = {
		efi = {
			canTouchEfiVariables = false;
		};
		systemd-boot = {
			enable = false;
			graceful = false;
		};
		grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
			efiInstallAsRemovable = true;
		};
	};



	networking = {
		hostName = "orlane";
		wireless.iwd = {
			enable = true;
			settings = {
				IPv6 = { Enabled = true; };
				Settings = { AutoConnect = true;};
			};
		};
	};


	i18n.defaultLocale = "fr_FR.UTF-8";

	users.users.orlane = {
		isNormalUser = true;
		description = "orlane";
		extraGroups = [ "networkmanager" ];
	};

	# Install firefox.
	programs = {
		firefox.enable = true;
		git = {
			enable = true;
			userName = "";
			userEmail = "";
		};
		starship = {
			enable = true;
			settings = {
				add_newline = false;
				aws.disabled = true;
				gcloud.disabled = true;
				line_break.disabled = true;
			};
		};
		fish = {
			enable = true;
			interactiveShellInit = ''
				set fish_greeting # Disable greeting
				eval "$(direnv hook fish)"
				alias nswitch="rm ~/.gtkrc-2.0 && nh os switch"
				alias dofus="appimage-run ~/Games/DOFUS/Ankama\ Launcher-Setup-x86_64.AppImage"
			'';
		};
	};

	nixpkgs.config.allowUnfree = true;

	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
