{ config, ... }:
{
  nixosHosts.kix_vm = {
	system = "x86_64-linux";
    primaryUser = "kiki";
    unstable = true;
    tags = [ "vm" "kix_vm" ];

    modules = [
      ./_nixos
    ]
	#modules default
    ++ (with config.flake.modules.nixos; [
		core
    ]);

	homeManagerModules = [
		./_home/home.nix
	]
	++ (with config.flake.modules.homeManager; [
		core
		nixvim
	]);
  };
}
