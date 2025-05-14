{ pkgs, inputs, ...}:

{
	imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
	nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
	services.tailscale.enable = true;

	systemd.services.tailscale-autoconnect = {
		description = "Automatic connection to Tailscale";
		after = [ "network-pre.target" "tailscale.service" ];
		wants = [ "network-pre.target" "tailscale.service" ];
		wantedBy = [ "multi-user.target" ];

		serviceConfig.Type = "oneshot";
	};
	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 25565 ];
		allowedUDPPorts = [ 25565 ];
	};

	services.minecraft-servers = {
		enable = true;
		eula = true;
		servers  = {
			nixosrpi4 = {
				enable = true;
				package = pkgs.papermcServers.papermc-1_21_4;
				symlinks = {
					#"mods" = ./mods;
				};
				serverProperties = {
					server-port = 25565;
					server-ip = "0.0.0.0";
					samemode = "survival";
					difficulty = "normal";
					simulation-distance = 4;
					view-distance = 6;
					level-sedd = "4";
					max-tick-time = 15000;
					max-players = 5;
					motd = "NixOS Minecraft server!";
				};
			};
		};
	};
}
