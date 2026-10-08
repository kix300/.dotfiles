{pkgs, ...}:
{
	# imports = [
	# 	./docker.nix
	# ];
	networking.firewall.allowedTCPPorts = [ 6443 ];

	services.k3s.enable = true;
	services.k3s.role = "server";

	environment.systemPackages = with pkgs; [
		k3s
		k3d
		kubectl
		kubernetes-helm
	];

}
