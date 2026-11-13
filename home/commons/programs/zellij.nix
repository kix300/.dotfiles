{ _ , ... }:
{
	programs.zellij = {
		settings = {
			theme_dark= "catppuccin-latte";
			theme_light = "catppuccin-latte";
			show_startup_tips = false;
		};
		enable = true;
		enableFishIntegration = false;
		exitShellOnExit = false;
		attachExistingSession = false;
	};
}
