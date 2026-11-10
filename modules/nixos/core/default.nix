{ pkgs, ... }:

{
	imports = [
		./packages.nix
		./programs.nix
		./services.nix
		./virtualisation/libvirt.nix
		./virtualisation/docker.nix
		./other.nix
	];
}
