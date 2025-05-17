{ pkgs, ... }:


{
  # Activation du service Tailscale
  services.tailscale.enable = true;

  # Connexion automatique au démarrage
  systemd.services.tailscale-autoconnect = {
    description = "Connexion automatique Tailscale pour Orlane";
    
    after = [ "network.target" "tailscale.service" ];
    wants = [ "network.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    script = with pkgs; ''
      # Attente de la disponibilité du service Tailscale
      until ${tailscale}/bin/tailscale status; do
        sleep 1
      done

      # Lecture de la clé et connexion
      AUTH_KEY=$(cat /etc/tailscale/authkey)
      ${tailscale}/bin/tailscale up \
        --authkey "$AUTH_KEY" \
        --hostname ${config.networking.hostName} \
        --operator=orlane
    '';
  };

  # Configuration du firewall
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ 41641 ];
  };

  # Activation SSH
  services.openssh.enable = true;

}
