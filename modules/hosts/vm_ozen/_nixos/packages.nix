{ pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	users.users.kiki.packages = with pkgs; [
		kdePackages.kate
		kubernetes
		kubernetes-helm
	];
}
