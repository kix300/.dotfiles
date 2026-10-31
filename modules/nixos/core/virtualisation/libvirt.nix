{ config, pkgs, ... }:

let
	virt-manager-x11 = pkgs.symlinkJoin {
		name = "virt-manager-x11";
		paths = [ pkgs.virt-manager ];
		nativeBuildInputs = [ pkgs.makeWrapper ];
		postBuild = ''
	  wrapProgram $out/bin/virt-manager --set GDK_BACKEND x11
	  '';
	};
in
	{
	programs.virt-manager = {
		enable = true;
		package = virt-manager-x11;
	};

	virtualisation = {
		libvirtd = {
			enable = true;
			qemu = {
				package = pkgs.qemu;
				vhostUserPackages = with pkgs; [ virtiofsd ];
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
