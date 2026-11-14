{
	flake.modules.nixos.package-desktop =
		{ pkgs, inputs, ... }:
		{
			environment.systemPackages = with pkgs; [
				ghostty
				iwgtk
				kitty
				loupe
				matugen
				pavucontrol
				thunar
				wayvnc
				inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
				inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
			];
		};
}
