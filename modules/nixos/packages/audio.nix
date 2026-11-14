{
	flake.modules.nixos.package-audio =
		{ pkgs, ... }:
		{
			environment.systemPackages = with pkgs; [
				easyeffects
				jack2
			];
		};
}
