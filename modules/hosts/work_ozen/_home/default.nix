
{ ... }:
{
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
	home.stateVersion = "23.11";
}
