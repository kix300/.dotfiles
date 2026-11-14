{
	flake.modules.nixos.package-apps =
		{ pkgs, ... }:
		{
			environment.systemPackages = with pkgs; [
				asusctl
				discord
				obs-studio
				obsidian
			];
		};
}
