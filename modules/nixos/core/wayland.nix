{
	flake.modules.nixos.wayland =
		{ pkgs, ... }:
		{
			xdg.portal = {
				enable = true;
				config.common.default = [ "gtk" ];
				extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
			};

			environment.sessionVariables.NIXOS_OZONE_WL = "1";
		};
}
