{ pkgs, ... }:
{

	services.tailscale.enable = false;

	systemd.services.tailscale-autoconnect = {
		description = "Automatic connection to Tailscale";
		after = [ "network-pre.target" "tailscale.service" ];
		wants = [ "network-pre.target" "tailscale.service" ];
		wantedBy = [ "multi-user.target" ];

		serviceConfig.Type = "oneshot";

		script = ''
# Attend que Tailscale soit prêt
until ${pkgs.tailscale}/bin/tailscale status; do
sleep 1
done

# Se connecte (si pas déjà fait)
			${pkgs.tailscale}/bin/tailscale up --authkey=tskey-auth-keVXrhVVF411CNTRL-AT8VgZqrWe55gySYcQJoe5hUZmAVeZyG'';
	};
}
