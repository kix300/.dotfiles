{ pkgs, ... }:

{
	services.tailscale.enable = true;

	# Configuration système pour une connexion fiable au démarrage
	systemd.services.tailscale-autoconnect = {
		description = "Connexion automatique Tailscale";

		# Dépendances critiques pour le timing de démarrage
		after = [ 
			"network.target" 
			"network-online.target" 
			"tailscale.service" 
		];
		wants = [ 
			"network-online.target" 
			"tailscale.service" 
		];
		requires = [ "network-online.target" ];
		wantedBy = [ "multi-user.target" ];

		# Configuration du service
		serviceConfig = {
			Type = "oneshot";
			Restart = "on-failure";
			RestartSec = "5s";
			RemainAfterExit = "yes";
		};

		# Script amélioré avec gestion d'erreur
		script = with pkgs; ''
	  set -euo pipefail

	  echo "Attente de la disponibilité du réseau..."
			${systemd}/bin/systemctl is-active --quiet network-online.target

	  echo "Vérification du service Tailscale..."
	  retry=0
	  max_retries=10
	  until ${tailscale}/bin/tailscale status; do
		if [ $retry -ge $max_retries ]; then
		  echo "Timeout: Service Tailscale non disponible"
		  exit 1
		fi
		echo "Service Tailscale pas encore prêt ($retry/$max_retries)..."
		sleep 3
		((retry++))
	  done

	  echo "Lecture de la clé d'authentification..."
	  AUTH_KEY=$(cat /etc/tailscale/authkey)

	  echo "Connexion au réseau Tailscale..."
			${tailscale}/bin/tailscale up \
		--authkey "$AUTH_KEY" \
		--hostname orlane\
		--reset
		'';
	};

	# Configuration réseau
	networking.firewall = {
		enable = true;
		trustedInterfaces = [ "tailscale0" ];
		allowedUDPPorts = [ 41641 ];
	};

	services.openssh = {
		enable = true;
	};
}
