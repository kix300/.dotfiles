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
    ]);
	#moduels flake
	# ++ (with config.flake.modules.flake; [
	# 	nixvim
	# ]);

	#modules homemanager 
    # homeManagerModules = with config.flake.modules.homeManager; [
    #   ssh-hosts
    # ];
  };
}
