{ config, ... }:

{
	flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
		misc
		nvidia
		packages
		prepkgs
		programs
		services
		# virtualisation
	];
}
