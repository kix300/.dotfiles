# docker.nix cannot be in same time as podman.nix
{ _ , ...}:
{
	virtualisation = {
		docker = {
			enable = true;
			rootless = {
				enable = true;
				setSocketVariable = true;
			};
		};
	};

}
