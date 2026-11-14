{ pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	users.users.ozen_work.packages = with pkgs; [
		glib
		kdePackages.kpeople
		nautilus
		sshfs
		wireshark
		xwayland
		xwayland-satellite
	];
}
