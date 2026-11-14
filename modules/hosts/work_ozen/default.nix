{ config, ... }:
{
	nixosHosts.work = {
		system = "x86_64-linux";
		primaryUser = "ozen_work";
		unstable = true;
		tags = [ "machines" "work" ];

		modules = [
			./_nixos
		]
			#modules default
			++ (with config.flake.modules.nixos; [
				core
				package-base
				package-desktop
				package-development
				package-audio
				package-apps
				wayland
				virtualisation
			]);

		#modules homemanager 
		homeManagerModules = [
			./_home
		]
			++ (with config.flake.modules.homeManager; [
				core
				nixvim
				niri
			]);
	};
}
