{ pkgs, ... }:
{

	services.tailscale.enable = false;

	systemd.services.tailscale-autoconnect = {
		description = "Automatic connection to Tailscale";
		after = [ "network-pre.target" "tailscale.service" ];
		wants = [ "network-pre.target" "tailscale.service" ];
		wantedBy = [ "multi-user.target" ];

		serviceConfig.Type = "oneshot";
	};
}
