{
	flake.modules.homeManager.niri =
		{ ... }:
		{
			programs.niri.enable = true;
			xdg.configFile."niri/config.kdl".source =
				../../hosts/work_ozen/_home/niri/config.kdl;
		};
}
