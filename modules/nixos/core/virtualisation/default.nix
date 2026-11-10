{ config, ... }:

{
	flake.modules.nixos.virtualisation.imports = with config.flake.modules.nixos; [
		docker
		k3s
		# kubernetes
		libvirt
		# podman
		# virtualbox
	];
}

