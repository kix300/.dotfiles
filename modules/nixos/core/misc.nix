{

	flake.modules.nixos.base =

	{ pkgs, ... }:

	{
		environment.variables.EDITOR = "nvim";
		nix.settings.experimental-features = [
			"nix-command"
				"flakes"
		];
		networking = {
			networkmanager.enable = true;
			wireless.iwd = {
				enable = false;
			};
		};
		console.useXkbConfig = true;
		time.timeZone = "Europe/Paris";

		i18n = {
			defaultLocale = "en_US.UTF-8";
			extraLocaleSettings = {
				LC_ADDRESS = "fr_FR.UTF-8";
				LC_IDENTIFICATION = "fr_FR.UTF-8";
				LC_MEASUREMENT = "fr_FR.UTF-8";
				LC_MONETARY = "fr_FR.UTF-8";
				LC_NAME = "fr_FR.UTF-8";
				LC_NUMERIC = "fr_FR.UTF-8";
				LC_PAPER = "fr_FR.UTF-8";
				LC_TELEPHONE = "fr_FR.UTF-8";
				LC_TIME = "fr_FR.UTF-8";
			};
		};

		security = {
			polkit.enable = true;
			polkit.extraConfig = ''
				polkit.addRule(function(action, subject) {
						if (action.id == "org.freedesktop.policykit.exec" &&
								action.lookup("program") == "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server" &&
								subject.isInGroup("video")) {
						return polkit.Result.YES;
						}
						});
			'';
			pam = {
				services = {
					swaylock = { };
				};
			};
		};

		fonts.packages = with pkgs; [
			fira-code
				fira-code-symbols
				nerd-fonts.fira-code
		];
	};
}
