# podman.nix cannot be in same time as docker.nix
{
	flake.modules.nixos.podman =
		{pkgs, lib, ...}:
		{
			environment.systemPackages = with pkgs; [
				podman-compose
			];
			virtualisation = {
				docker.enable = lib.mkForce false;
				containers.enable = true;
				podman = {
					enable = true;
					dockerCompat = true;
					defaultNetwork.settings.dns_enabled = true;
				};
			};
		};
}
