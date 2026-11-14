{
	flake.modules.nixos.package-base =
		{ pkgs, ... }:
		{
			environment.systemPackages = with pkgs; [
				vim
				fish
				bluez
				brightnessctl
				ddcutil
				gh
				util-linux
			];
		};
}
