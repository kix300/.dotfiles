{
	flake.modules.nixos.nvidia =
		{ _, ... }:
		{
			hardware.nvidia = {
				open = false;
				prime = {
					offload.enable = true;
					offload.enableOffloadCmd = true;
					sync.enable = false;
				};
				dynamicBoost.enable = true;
				modesetting.enable = true; # askip regle le probleme du usb-c
				powerManagement.enable = true;
				powerManagement.finegrained = true;
				nvidiaSettings = true;
			};
		};
}
