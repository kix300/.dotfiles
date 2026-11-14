{
	flake.modules.homeManager.zoxide =
		{ _ , ... }:
		{
	programs.zoxide = {
		enable = true;
	};
		};
}
