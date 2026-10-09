{pkgs, ...}:
{
	# imports = [
	# 	./docker.nix
	# ];
	networking.firewall.allowedTCPPorts = [ 6443 ];

	services.k3s = {
		enable = false;
		role = "server";
	};

	environment.systemPackages = with pkgs; [
		k3s
		k3d
		kubectl
		kubernetes
		kubernetes-helm
	];

}
