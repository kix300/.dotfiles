# docker.nix cannot be in same time as podman.nix
{
	flake.modules.nixos.docker = 
		{ _ , ...}:
		{
			virtualisation = {
				docker = {
					enable = true;
				};
			};

		};
}
