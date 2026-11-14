{ inputs, ... }:

{
  flake.modules.nixos.packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Base
      vim
      fish
      bluez
      brightnessctl
      ddcutil
      gh
      util-linux

      # Applications
      asusctl
      discord
      obs-studio
      obsidian

      # Audio
      easyeffects
      jack2

      # Desktop
      ghostty
      iwgtk
      kitty
      loupe
      matugen
      pavucontrol
      thunar
      wayvnc
      inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
      inputs.noctalia.packages.${stdenv.hostPlatform.system}.default

      # Development
      clang
      clang-tools
      cmake
      comma
      gnumake
      libbsd
      libclang
      libgcc
      libgccjit
      lua
      pnpm
      tmux
      uv
      valgrind
    ];
  };
}
