{ config, ... }:
{
  nixosHosts.work = {
	system = "x86_64-linux";
    unstable = true;
    tags = [ "machines" "work" ];

    modules = [
      ./_nixos
    ]
	#modules default
    ++ (with config.flake.modules.nixos; [
      core
    ]);

	#modules homemanager 
    # homeManagerModules = with config.flake.modules.homeManager; [
    #   ssh-hosts
    # ];
  };
}
