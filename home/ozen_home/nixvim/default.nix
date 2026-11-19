{ _ , ... }:

{
	programs.nixvim = {
	xdg.configFile."nvim/lua/plugins/noctalia.lua".source = ./noctalia.lua;
	};
}
