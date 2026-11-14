{
	flake.modules.homeManager.niri =
		{ ... }:
		{
			programs.niri.enable = true;
			xdg.configFile."niri/config.kdl".source =
				./config.kdl;
		};
}
