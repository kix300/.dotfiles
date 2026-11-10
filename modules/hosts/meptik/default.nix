{ config, ... }:
{
  nixosHosts.meptik = {
	system = "x86_64-linux";
    unstable = true;
    tags = [ "machines" "meptik" ];

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
