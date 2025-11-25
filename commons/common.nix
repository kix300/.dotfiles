{ pkgs, ... }:

{
  services = {
    udev.enable = true;
    gvfs.enable = true;
    supergfxd.enable = true;
    printing.enable = true;
    upower.enable = true;
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
  };
  hardware = {
    i2c.enable = false;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    graphics = {
      enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    xfconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    fish
    clang
    clang-tools
    git
    gnumake
    ghostty
    grim
    iwgtk
    libbsd
    libclang
    libgcc
    libgccjit
    pnpm
    readline
    readline70
    rust-analyzer
    valgrind
    util-linux
    # xwaylandvideobridge

  ];

  time.timeZone = "Europe/Paris";

  i18n = {
    extraLocaleSettings = {
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
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam = {
      services = {
        swaylock = { };
        hyprlock = { };
      };
    };
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
  ];
}
