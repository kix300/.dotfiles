{pkgs, ...}:
{
	services = {
		udev.enable = true;
		gvfs.enable = true;
		supergfxd.enable = true;
		printing.enable = true;
		upower.enable = true;
		blueman.enable = true;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			jack.enable = true;
			pulse.enable = true;
			wireplumber.enable = true;
		};
		libinput.enable = true;
		xserver = {
			enable = true;
			xkb = {
				layout = "us";
				variant = "";
			};
		};
	};
	virtualisation = {
		libvirtd = {
			enable = true;
			qemu.vhostUserPackages = with pkgs; [ virtiofsd ];  # ← this is the fix
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
