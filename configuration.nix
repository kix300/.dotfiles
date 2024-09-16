
{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      #./hypr/hyprland.nix
      #./nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


	services.xserver = {
		enable = true;
		videoDrivers = ["nouveau" "nvidia" "nvidia_drm" "nvidia_modeset"]; # or "nvidiaLegacy470 etc.
	};

	hardware.nvidia.open = false;
	services.displayManager.sddm.enable = true;
	#services.xserver.displayManager.lightdm.enable = true;
	services.desktopManager.plasma6.enable = true;
	services.supergfxd.enable = true;
	services.gvfs.enable = true;

	/*

	hardware.nvidia = {
			  prime.offload.enable = lib.mkForce true;
			  prime.offload.enableOffloadCmd = lib.mkForce true;
			  prime.sync.enable = lib.mkForce true;
			  dynamicBoost.enable = lib.mkForce true;
			  modesetting.enable = lib.mkForce true;
			  powerManagement.enable = lib.mkForce true;
			  powerManagement.finegrained = lib.mkForce true;
			  nvidiaSettings = lib.mkForce true;
		  };
	*/

  hardware.i2c.enable = true;

  networking.hostName = "OzenOs"; # Define your hostname.

  networking.wireless.iwd.enable = true;

  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Set default editor to nvim
  environment.variables.EDITOR = "hx";

  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable upower services
  services.upower.enable = true;

  # Enable sound with pipewire.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = true;
  };


  users.users.ozen = {
    isNormalUser = true;
    description = "Killian";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "lp" "i2c"];
    packages = with pkgs; [
      kate
    #  thunderbird
    ];
  };
  programs.bash = {
    interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
    '';
  };

   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.guest.enable = true;
   users.extraGroups.vboxusers.members = [ "ozen wheel" ];

  programs.adb.enable = true;

  services.udev.enable = true;

  programs.steam = {
    enable = true;
    extest.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    firefox-devedition
    kitty
    rofi-wayland
    rofi-power-menu
    ntfs3g
  	telegram-desktop
    swaylock-fancy
    discord
    brightnessctl
    ddcui
    dolphin
    ddcutil
  	libgccjit
  	binutils
  	prismlauncher
  	aircrack-ng
  	hyprlock
  	comma
  	helix
    grim
    nil
    rocmPackages_5.llvm.clang
    gnumake
    libsForQt5.breeze-qt5
	heroic
	rpi-imager
	valgrind
	libgcc
	apktool
	ilspycmd
	android-tools
	adbtuifm
	anbox
	dotnet-runtime
	openjdk
	aapt
  ];
  #programs.nix-index-database.comma.enable = true;
  security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };



  #Font packages 
  fonts.packages = with pkgs; [
	  fira-code
	  fira-code-symbols
	  fira-code-nerdfont
  ];

  qt = {
    enable = true;
    style = "breeze";
	platformTheme = "kde";
  };

  specialisation = {
	  WORK_NOT_KDE.configuration = {
		  services.xserver = {
			  enable = lib.mkForce false;
			  videoDrivers = ["nouveau" "nvidia_drm" "nvidia_modeset"]; # or "nvidiaLegacy470 etc.
		  };
		  services.displayManager.sddm.enable = lib.mkForce false;
		  services.desktopManager.plasma6.enable = lib.mkForce false;
		  system.nixos.tags = [ "without_nvidia" ];

		  hardware.nvidia = {
			  prime.offload.enable = lib.mkForce false;
			  prime.offload.enableOffloadCmd = lib.mkForce false;
			  prime.sync.enable = lib.mkForce false;
			  dynamicBoost.enable = lib.mkForce false;
			  modesetting.enable = lib.mkForce false;
			  powerManagement.enable = lib.mkForce false;
			  powerManagement.finegrained = lib.mkForce false;
			  nvidiaSettings = lib.mkForce false;
			  open = false;
		  };
		  boot.extraModprobeConfig = ''
			  blacklist nouveau
			  options nouveau modeset=0
			  '';

		  services.udev.extraRules = ''
# Remove NVIDIA USB xHCI Host Controller devices, if present
			  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
# Remove NVIDIA USB Type-C UCSI devices, if present
			  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
# Remove NVIDIA Audio devices, if present
			  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
# Remove NVIDIA VGA/3D controller devices
			  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
			  '';
		  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
	  };
  }; 
# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
