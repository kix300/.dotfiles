{ config, ... }:
{
  nixosHosts.home = {
	system = "x86_64-linux";
    primaryUser = "ozen";
    unstable = true;
    tags = [ "machines" "home" ];

    modules = [
      ./_nixos
    ]
	#modules default
    ++ (with config.flake.modules.nixos; [
      core
      nvidia
      package-base
      package-desktop
      package-development
      package-audio
      package-apps
      wayland
      virtualisation
    ]);

	homeManagerModules = [
		./_home
	]
		++ (with config.flake.modules.homeManager; [
			core
			nixvim
			hyprland
		]);
  };
}
