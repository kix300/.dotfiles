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
    ]);

	homeManagerModules = [
		./_home
	]
	++ (with config.flake.modules.homeManager; [
		core
		nixvim
		noctalia
		hyprland
		]);
  };
}
