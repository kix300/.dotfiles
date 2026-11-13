
{ ... }:
{
	imports = [
		./../commons/Hcommons.nix
	];
	home = {
		username = "ozen_work";
		homeDirectory = "/home/ozen_work";
	};

	programs = {
		home-manager.enable = true;
		fish = {
			interactiveShellInit = ''
				 set -x KUBECONFIG $HOME/.kube/config
				 alias k="kubectl"
			'';
		};
	};
	xdg.configFile."niri/config.kdl".source = niri/config.kdl;

	home.stateVersion = "23.11";
}
