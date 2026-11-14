{ config, ... }:

{
	flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
		base
		hardware
		audio
		prepkgs
		programs
		services
	];
}
