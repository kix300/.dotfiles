{
	flake.modules.homeManager.zellij =
		{ _ , ... }:
		{
	programs.zellij = {
		settings = {
			show_startup_tips = false;
		};
		enable = true;
		enableFishIntegration = false;
		exitShellOnExit = false;
		attachExistingSession = false;
	};
		};
}
