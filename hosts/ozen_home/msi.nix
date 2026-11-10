{_ , ...}:
{
	systemd.services.nvidia-power-limit = {
		description = "Set NVIDIA GPU power limit";
		wantedBy = [ "multi-user.target" ];
		after = [ "systemd-modules-load.service" ];
		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
			ExecStart = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi -pl 160";
		};
	};
}
