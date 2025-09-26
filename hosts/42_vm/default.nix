{ config, pkgs, lib, ... }:

{
	imports =
		[ 
		./hardware-configuration.nix
 		../../commons/common.nix
		];

	boot = {
		extraModulePackages = [ config.boot.kernelPackages.virtualboxGuestAdditions ];
			loader = {
				grub = {
					enable = true;
					device = "/dev/sda";
					useOSProber = true;
				};
			};
	};
	environment.variables.EDITOR = "vim";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];


	networking = {
		hostName = "forty_two_vm";
		networkmanager.enable = true;
	};

	virtualisation.virtualbox.guest.enable = true;
	virtualisation.virtualbox.guest.dragAndDrop = true;
	services.xserver.videoDrivers = [ "virtualbox" ];
	services.spice-vdagentd.enable = true;

	virtualisation.docker = {
		enable = true;
		daemon.settings = {
			userns-remap = "default";
			storage-driver = "overlay2";
		};
	};
	virtualisation.docker.rootless = {
		enable = true;
		setSocketVariable = true;
	};

	users.users.kix = {
		isNormalUser = true;
		description = "Kix";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			docker-compose
				vscodium
				vscode
				firefox
				solana-cli
				anchor
				zed-editor

		];
	};
	programs = {
		bash = {
			interactiveShellInit = ''
				if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
					then
						shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
						exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
						fi
						'';
		};
	};

	nixpkgs.config.allowUnfree = true;

	system.stateVersion = "25.05";

}
