

{ ... }:
{
	services.xserver.videoDrivers = [ "amdgpu" "nvidia" "nvidia_drm" "nvidia_modeset" ];
	hardware.nvidia = {
		open = true;
		prime.offload.enable = true;
		prime.offload.enableOffloadCmd = true;
		prime.sync.enable = false;
		dynamicBoost.enable = true;
		modesetting.enable = true; # askip regle le probleme du usb-c
		powerManagement.enable = true;
		powerManagement.finegrained = true;
		nvidiaSettings = true;
	};
}
