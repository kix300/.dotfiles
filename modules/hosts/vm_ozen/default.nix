{ config, ... }:
{
  nixosHosts.kix_vm = {
	system = "x86_64-linux";
    unstable = true;
    tags = [ "vm" "kix_vm" ];

    modules = [
      ./_nixos
    ]
	#modules default
    ++ (with config.flake.modules.nixos; [
      core
      packages-vm
    ]);

	homeManagerModules = [
		./_home
	]
		++ (with config.flake.modules.homeManager; [
			core
		]);
  };
}
