{ pkgs, ... }:

{
	imports = [
		./minecraft.nix
	];
	boot = {
		kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
		initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
		loader = {
			grub.enable = false;
			generic-extlinux-compatible.enable = true;
		};
	};

	nix.settings.experimental-features = [ "flakes" ];
	nixpkgs.config.allowUnfree = true;

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-label/NIXOS_SD";
			fsType = "ext4";
			options = [ "noatime" ];
		};
	};

	networking = {
		hostName = "steve";
	};

	environment.systemPackages = with pkgs; [
		vim
			neovim
			fish
			git
			rcon
			libraspberrypi
			docker
	];

	virtualisation.docker.enable = true;
	services.openssh.enable = true;
	services.openssh.permitRootLogin = "no";

	users.users.steve = {
		isNormalUser = true;
		description = "steve";
		extraGroups = ["wheel"];
		packages = with pkgs; [
			vim
		];
	};

	hardware.enableRedistributableFirmware = true;
	system.stateVersion = "23.11";
}
