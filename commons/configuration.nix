{ ... }:

{
	imports = [
		./prepkgs.nix
	];
	environment.variables.EDITOR = "nvim";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};
	programs = {
		hyprland.portalPackage = true;
		hyprland.xwayland.enable = true;
		ssh.startAgent = true;
		nh = {
			enable = true;
			clean.enable = true;
			clean.extraArgs = "--keep-since 4d --keep 3";
			flake = "/home/ozen/.dotfiles";
		};
		adb.enable = true;
		steam = {
			enable = true;
			extest.enable = true;
		};
	};

	i18n = {
		defaultLocale = "en_US.UTF-8";
	};

	virtualisation = {
		virtualbox = {
			host.enable = false;
			host.enableExtensionPack = false;
			guest.enable = false;
			guest.dragAndDrop = false;
		};
	};
}
