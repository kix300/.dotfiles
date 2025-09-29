{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../commons/configuration.nix
    ../../commons/common.nix
    ../../commons/nvidia.nix
  ];

  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
    wireless.iwd = {
      enable = false;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        "Gibus" = {
          AutoConnect = "true";
          # Fréquences 5 GHz usuelles en France (pas de 2,4 GHz)
          Frequencies = "5180,5200,5220,5240,5260,5280,5300,5320,5500,5520,5540,5560,5580,5660,5680,5700,5720,5745,5765,5785,5805";
        };
        IPv6 = {
          Enabled = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  users.extraGroups.vboxusers.members = [ "ozen wheel" ];
  users.users.ozen = {
    isNormalUser = true;
    description = "Killian";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "lp"
      "i2c"
      "docker"
      "video"
      "audio"
    ];
    packages = with pkgs; [
      lshw
      asusctl
      pavucontrol
      aapt
      adbtuifm
      adwaita-icon-theme
      aircrack-ng
      android-tools
      #android-studio
      apktool
      appimage-run
      bear
      brightnessctl
      clang-tools
      comma
      ddcui
      ddcutil
      direnv
      discord
      distrobox
      fd
      gemini-cli
      glfw
      godot
      heroic
      hyprlock
      #jadx
      kdePackages.qtsvg
      kdePackages.qtwayland
      kdePackages.qtdeclarative
      kdePackages.full
      kitty
      lua
      nil
      nodejs
      norminette
      ntfs3g
      obs-studio
      openjdk
      prismlauncher
      python3
      qbittorrent
      r2modman
      rofi-power-menu
      rofi
      rpi-imager
      signal-desktop
      spotify
      supabase-cli
      swaylock-fancy
      telegram-desktop
      util-linux
      vimPlugins.nvim-treesitter-parsers.qmljs
      vscode
      wayvnc
      wine
      wofi
      # xdg-desktop-portal-gtk
      # xdg-desktop-portal-hyprland
      xfce.thunar
      inputs.zen-browser.packages."${system}".default
      inputs.quickshell.packages."${system}".default
    ];
  };
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # for charging phone
  services.logind.settings.Login = {
    HandlelidSwitch = "ignore";
    HandlelidSwitchDocked = "ignore";
    HandlelidSwitchExternalPower = "ignore";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
    config = {
      common.default = "*";
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ rtl8812au ];
    kernelModules = [
      "8812au"
      "amdgpu.dc=1"
      "iwlwifi"
      "iwlmvm"
      "amdgpu"
      "ucsi_ccg"
    ];
    kernelParams = [
      "iwlwifi.11ax_disable=0" # Active le Wi-Fi 6 (802.11ax)
      "iwlwifi.power_save=0" # Désactive l'économie d'énergie (peut améliorer les perfs)
    ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  hardware.enableRedistributableFirmware = true;
  services = {
    xserver = {
      enable = lib.mkForce false;
    };
    displayManager.sddm.enable = lib.mkForce false;
    desktopManager.plasma6.enable = lib.mkForce false;
    displayManager.gdm.enable = lib.mkForce false;
    desktopManager.gnome.enable = lib.mkForce false;
  };

  qt.enable = false;

  # hardware = {
  # 	nvidia = {
  # 		prime.offload.enable = lib.mkForce false;
  # 		prime.offload.enableOffloadCmd = lib.mkForce false;
  # 		prime.sync.enable = lib.mkForce false;
  # 		dynamicBoost.enable = lib.mkForce false;
  # 		modesetting.enable = lib.mkForce false;
  # 		powerManagement.enable = lib.mkForce false;
  # 		powerManagement.finegrained = lib.mkForce false;
  # 		nvidiaSettings = lib.mkForce false;
  # 		open = lib.mkForce false;
  # 	};
  # };
  # boot.extraModprobeConfig = ''
  # 			blacklist nouveau
  # 			options nouveau modeset=0
  # '';
  #
  # services.udev.extraRules = ''
  # 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
  # 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
  # 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
  # 			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  # '';
  # ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"

  # boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
