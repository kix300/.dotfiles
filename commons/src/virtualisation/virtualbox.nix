{_ , ...}:
{
	users.extraGroups.vboxusers.members = [ "ozen" "ozen_work" "ozen_home" ];
	nixpkgs.config.allowUnfree = true;
	virtualisation.virtualbox = {
		host = {
			enable = false;
			enableExtensionPack = true;
		};
		guest = {
			enable = true;
			dragAndDrop = true;
		};
	};
}
