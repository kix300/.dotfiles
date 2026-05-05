{ lib, ... }:
{

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"nvidia-x11"
		"nvidia-settings"
		"android-studio"
		"steam"
		"steam-original"
		"steam-unwrapped"
		"steam-run"
	];
}
