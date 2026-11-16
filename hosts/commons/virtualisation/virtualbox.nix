{_ , ...}:
{
	users.extraGroups.vboxusers.members = [ "ozen" "ozen_work" "ozen_home" ];
	nixpkgs.config.allowUnfree = true;
	virtualisation.virtualbox = {
		host = {
			enable = true;
			enableExtensionPack = true;
		};
		guest = {
			enable = true;
			dragAndDrop = true;
		};
	};
}
