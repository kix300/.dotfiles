{ pkgs, ... }:

{

	services.tailscale.enable = true;

	systemd.services.tailscale-autoconnect = {
		after = [ "network-pre.target" "tailscale.service" ];
		wants = [ "network-pre.target" "tailscale.service" ];
		wantedBy = [ "multi-user.target" ];

		serviceConfig.Type = "oneshot";

		script = with pkgs; ''
	  until ${tailscale}/bin/tailscale status; do
		sleep 1
	  done

	  AUTH_KEY=$(cat /etc/tailscale/authkey)
			${tailscale}/bin/tailscale up --authkey "$AUTH_KEY" --hostname orlane
		'';
	};

	networking.firewall = {
		enable = true;
		trustedInterfaces = [ "tailscale0" ];
		allowedUDPPorts = [ 41641 ];
	};

	services.openssh.enable = true;
}
