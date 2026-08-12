{pkgs, ...}:
{
	virtualisation = {
		# virtualbox = {
		# 	host = {
		# 		enable = true;
		# 		enableExtensionPack = true;
		# 	};
		# 	guest = {
		# 		enable = true;
		# 		dragAndDrop = true;
		# 		clipboard = true;
		# 	};
		# };
		libvirtd = {
			enable = true;
			qemu = {
				vhostUserPackages = with pkgs; [ virtiofsd ];  # ← this is the fix
				package = pkgs.qemu_kvm;
			};

		};
		spiceUSBRedirection.enable = true;
	};
	systemd.services.libvirt-default-network = {
		description = "Start libvirt default network";
		after = ["libvirtd.service"];
		wantedBy = ["multi-user.target"];
		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
			ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
			ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
			User = "root";
		};
	};
}
